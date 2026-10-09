#!/bin/bash
# Claude Code statusline: worktree · branch · dirty · id · session title
#
# Built for several Claude sessions running against the same repo at once.
# Three things distinguish them, in the order they are useful:
#
#   ⑂        this is a linked worktree, not the main checkout
#   branch   which branch it is on
#   #abc123  the session-id prefix, which is what ListAgents shows as [ref]
#            in other sessions -- so this is the key that maps "ilion-c3"
#            in someone else's roster to a window on your screen
#   title    the session's own name, the fastest way to tell them apart
#   O5.5     the model, initial + version (F5.1, S5.5, H5.5)
#   87k/1M   how deep the session is: the context the NEXT request will
#            re-read (current_usage summed) over the window.
#            At 150k+ the context reads ⚠150k: past that, /handoff and restart
#            beats riding the session on (cache reads are the bill).
#
#   -COMMIT- the checkout has uncommitted files (blank when clean or -AWAIT-)
#   -PUSH-   no -COMMIT- or -AWAIT-, but commits sit ahead of the upstream
#   -AWAIT-  whether a background shell or agent this session
#            launched is still running (a launch ID in the transcript with no
#            task-notification status for it yet; the payload has no task field).
#
# The peer names themselves (ilion-c3, ilion-54) are assigned by the peer
# registry and are NOT in the statusline payload; the id prefix is the
# correlation key that is.
#
# Outside a git repo, prints the directory, id and title.

input=$(cat)

field() {  # field <jq-path> <regex-key>
  local v
  v=$(printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null)
  [ -z "$v" ] && v=$(printf '%s' "$input" |
    sed -n "s/.*\"$2\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -1)
  printf '%s' "$v"
}

dir=$(field '.workspace.current_dir // .cwd' 'current_dir')
[ -z "$dir" ] && dir="$PWD"
name=$(basename "$dir")

sid=$(field '.session_id' 'session_id')
id=""
[ -n "$sid" ] && id=" · #${sid:0:6}"

title=$(field '.session_name' 'session_name')
# Keep the tail of the bar readable: one line, no wrapping.
if [ ${#title} -gt 32 ]; then title="${title:0:29}..."; fi
[ -n "$title" ] && title=" · ${title}"

model=$(field '.model.display_name' 'display_name')
# "Opus 5 (1M context)" -> "Opus 5": the parenthetical is the same on every
# session that has it, so it costs bar width without distinguishing anything.
model=${model%% (*}
model=$(printf '%s' "$model" | sed 's/^\([A-Z]\)[a-z]* /\1/')
[ -n "$model" ] && model=" · ${model}"

# Depth: context from the last request's usage.
depth=""
ctx=$(printf '%s' "$input" | jq -r '(.context_window.current_usage // {}) | ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))' 2>/dev/null)
win=$(field '.context_window.context_window_size' 'context_window_size')
if [ "${ctx:-0}" -gt 0 ] 2>/dev/null; then
  k=$((ctx / 1000))
  w=""
  if [ "${win:-0}" -ge 1000000 ] 2>/dev/null; then w="/1M"
  elif [ "${win:-0}" -gt 0 ] 2>/dev/null; then w="/$((win / 1000))k"; fi
  if [ "$k" -ge 150 ]; then depth="${depth} · ⚠${k}k${w}"; else depth="${depth} · ${k}k${w}"; fi
fi

# Weekly budget pace: 7d 42%/57% is usage over share of the week elapsed,
# elapsed derived from rate_limits.seven_day.resets_at (epoch s). Usage ahead
# of the clock reads ⚠. Absent until the session's first API response.
pace=$(printf '%s' "$input" | jq -r --argjson now "$(date +%s)" '
  .rate_limits.seven_day // empty
  | select(.resets_at and .used_percentage != null)
  | (100 - ((.resets_at - $now) / 6048)) as $el
  | (if $el < 0 then 0 elif $el > 100 then 100 else $el end | floor) as $e
  | (.used_percentage | floor) as $u
  | (if $u > $e then "⚠" else "" end) + "7d \($u)%/\($e)%"' 2>/dev/null)
[ -n "$pace" ] && depth="${depth} · ${pace}"

# Background work: launched IDs minus those a task-notification has closed
# (logged as a user turn with origin.kind, or in older sessions a queue record).
tasks=""
tp=$(field '.transcript_path' 'transcript_path')
if [ -n "$tp" ] && [ -r "$tp" ]; then
  # Structured fields only: quoted text in a tool result must not count.
  running=$(grep -E 'backgroundTaskId|async_launched|task-notification' "$tp" 2>/dev/null | jq -rs '
    ([.[] | .toolUseResult? | objects
      | (.backgroundTaskId // (select(.status == "async_launched") | .agentId)) // empty] | unique) as $l
    | ([.[] | select(.origin.kind? == "task-notification" or .type == "queue-operation"
          or .type == "attachment") | tostring
      | scan("<task-id>([^<\\\\]+)</task-id>")[0]] | unique) as $e
    | $l - $e | length' 2>/dev/null)
  [ "${running:-0}" -gt 0 ] && tasks=" · -AWAIT-"
fi
depth="${depth}${tasks}"

if ! git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf '%s%s%s%s%s' "$name" "$id" "$title" "$model" "$depth"
  exit 0
fi

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
[ -z "$branch" ] && branch="detached@$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)"

# A linked worktree keeps its git dir outside its own toplevel.
top=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
common=$(git -C "$dir" rev-parse --git-common-dir 2>/dev/null)
case "$common" in /*) ;; *) common="$top/$common" ;; esac
mark=""
case "$common" in "$top"/*) ;; *) mark="⑂ " ;; esac

n=$(git -C "$dir" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
dirty=""
[ "${n:-0}" -gt 0 ] 2>/dev/null && dirty=" · -COMMIT-"
# Committed but not pushed: ahead of the upstream (no upstream, no marker).
if [ -z "$dirty" ]; then
  ahead=$(git -C "$dir" rev-list --count @{u}..HEAD 2>/dev/null)
  [ "${ahead:-0}" -gt 0 ] 2>/dev/null && dirty=" · -PUSH-"
fi
# Running work will likely change the tree further; commit once it lands.
[ "$tasks" = " · -AWAIT-" ] && dirty=""

# Branch is dropped when it only repeats the worktree directory name, which
# is the usual case for `.claude/worktrees/<x>` on branch `<x>` -- printing
# both costs half the bar and says nothing.
if [ "$branch" = "$name" ] || [ "$branch" = "worktree-$name" ]; then
  printf '%s%s%s%s%s%s%s' "$mark" "$name" "$id" "$title" "$model" "$depth" "$dirty"
else
  printf '%s%s · %s%s%s%s%s%s' "$mark" "$name" "$branch" "$id" "$title" "$model" "$depth" "$dirty"
fi
