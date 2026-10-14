#!/bin/bash
# Claude Code statusline, e.g.
#   headquarters @a4 #22f2 <master>: "Title" (O5.5 @ 95k/1M | 7d 47%/62%)  -COMMIT-
#
# Built for several Claude sessions running against the same repo at once:
#
#   ⑂        this is a linked worktree, not the main checkout
#   @a4      the peer name other sessions message it by (headquarters-a4),
#            from the session registry ~/.claude/sessions/<pid>.json; shortened
#            to its suffix when the rest is just this directory's name
#   #22f2    the first 4 hex of the session id (its transcript); with @a4, the
#            session name token_spend.py --session-label prints
#   <branch> which branch it is on; dropped when it repeats the directory name
#   title    the session's own name, the fastest way to tell them apart
#   O5.5     the model, initial + version (F5.1, S5.5, H5.5)
#   95k/1M   how deep the session is: the context the NEXT request will
#            re-read (current_usage summed) over the window.
#            At 150k+ the context reads !!150k: past that, /handoff and restart
#            beats riding the session on (cache reads are the bill).
#
#   -COMMIT- the checkout has uncommitted files (blank when clean or -AWAIT-)
#   -PUSH-   no -COMMIT- or -AWAIT-, but commits sit ahead of the upstream
#   -AWAIT-  whether a background shell or agent this session
#            launched or resumed is still running (a launch ID in the transcript with no
#            task-notification, TaskStop or user stop for it yet; the payload has no task field).
#
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
[ -n "$sid" ] && id=" #${sid:0:4}"
# Peer name: the registry entry whose sessionId is this session's.
if [ -n "$sid" ]; then
  peer=$(jq -r --arg s "$sid" 'select(.sessionId == $s) | .name // empty' ~/.claude/sessions/*.json 2>/dev/null | head -1)
  slug=$(printf '%s' "$name" | tr '_' '-')
  case "$peer" in
    "") ;;
    "$slug"-*) id=" @${peer#"$slug"-}${id}" ;;
    *) id=" @${peer}${id}" ;;
  esac
fi

title=$(field '.session_name' 'session_name')

# tmux window name: `Topic (@a4 #22f2)`, the title's first whole words (at
# most 18 chars, a trailing "and"/"of"/... dropped) and then the session's name
# as token_spend.py --session-label gives it; ~/.tmux.conf adds `5: ` and ` |`.
# Renamed only on change, since the status line redraws constantly.
if [ -n "$TMUX_PANE" ] && [ -n "$sid" ]; then
  wid="#${sid:0:4}"
  [ -n "$peer" ] && wid="@${peer#"$slug"-} ${wid}"
  wtitle=$(printf '%s' "$title" | awk '{o=""; for(i=1;i<=NF;i++){t=(o==""?$i:o" "$i); if(length(t)>18)break; o=t}; if(o=="" && NF)o=substr($1,1,18)
    n=split(o,w," "); while(n>1 && tolower(w[n])~/^(and|or|the|of|for|to|with|a|an|in|on)$/)n--;
    r=w[1]; for(i=2;i<=n;i++)r=r" "w[i]; print r}')
  wname="${wtitle:+$wtitle }(${wid})"
  sock=${TMUX%%,*}; case $sock in /*) ;; *) sock=$HOME/$sock ;; esac
  cur=$(tmux -S "$sock" display -p -t "$TMUX_PANE" '#W' 2>/dev/null)
  [ "$cur" != "$wname" ] && tmux -S "$sock" rename-window -t "$TMUX_PANE" "$wname" >/dev/null 2>&1
fi

# Keep the tail of the bar readable: one line, no wrapping.
if [ ${#title} -gt 32 ]; then title="${title:0:29}..."; fi
[ -n "$title" ] && title=" \"${title}\""

model=$(field '.model.display_name' 'display_name')
# "Opus 5 (1M context)" -> "Opus 5": the parenthetical is the same on every
# session that has it, so it costs bar width without distinguishing anything.
model=${model%% (*}
model=$(printf '%s' "$model" | sed 's/^\([A-Z]\)[a-z]* /\1/')
[ -n "$model" ] && model="${model}"

# Depth: context from the last request's usage.
depth=""
ctx=$(printf '%s' "$input" | jq -r '(.context_window.current_usage // {}) | ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))' 2>/dev/null)
win=$(field '.context_window.context_window_size' 'context_window_size')
if [ "${ctx:-0}" -gt 0 ] 2>/dev/null; then
  k=$((ctx / 1000))
  w=""
  if [ "${win:-0}" -ge 1000000 ] 2>/dev/null; then w="/1M"
  elif [ "${win:-0}" -gt 0 ] 2>/dev/null; then w="/$((win / 1000))k"; fi
  if [ "$k" -ge 150 ]; then depth="!!${k}k${w}"; else depth="${k}k${w}"; fi
fi

# Weekly budget pace: 7d 42%/57% is usage over share of the week elapsed,
# elapsed derived from rate_limits.seven_day.resets_at (epoch s). Usage ahead
# of the clock reads !!. Absent until the session's first API response.
pace=$(printf '%s' "$input" | jq -r --argjson now "$(date +%s)" '
  .rate_limits.seven_day // empty
  | select(.resets_at and .used_percentage != null)
  | (100 - ((.resets_at - $now) / 6048)) as $el
  | (if $el < 0 then 0 elif $el > 100 then 100 else $el end | floor) as $e
  | (.used_percentage | floor) as $u
  | (if $u > $e then "!!" else "" end) + "7d \($u)%/\($e)%"' 2>/dev/null)
[ -n "$pace" ] && depth="${depth:+$depth | }${pace}"

# Background work: launched IDs minus those a task-notification has closed
# (logged as a user turn with origin.kind, or in older sessions a queue record).
tasks=""
tp=$(field '.transcript_path' 'transcript_path')
if [ -n "$tp" ] && [ -r "$tp" ]; then
  # Structured fields only: quoted text in a tool result must not count.
  # Replayed in order: a launch or a SendMessage resume opens an ID, its
  # task-notification closes it, so an agent resumed after it finished counts again.
  # $open must always bind (null when the record launches nothing): a reduce step
  # that yields no output is skipped, which would drop every closing record.
  running=$(grep -E 'backgroundTaskId|async_launched|resumedAgentId|task-notification|Successfully stopped task|was stopped by the user' "$tp" 2>/dev/null | jq -rs '
    reduce .[] as $r ({};
      ([$r.toolUseResult? | objects
        | (.backgroundTaskId // (select(.status == "async_launched") | .agentId)
           // .resumedAgentId) // empty][0]) as $open
      | if $open then .[$open] = 1 else . end
      # An agent the user stops is reported by its description only.
      | ([$r.toolUseResult? | objects | select(.status == "async_launched") | [.description, .agentId]][0]) as $d
      | if $d then .["desc:" + $d[0]] = $d[1] else . end
      | ([$r | select(.type == "queue-operation") | .content? | strings
          | capture("^Background agent \"(?<d>.*)\" was stopped by the user").d][0]) as $ud
      | if $ud and .["desc:" + $ud] then .[.["desc:" + $ud]] = 0 else . end
      # TaskStop ends a task without a task-notification.
      | ([$r.toolUseResult? | objects | select((.message? // "") | startswith("Successfully stopped task"))
          | .task_id // empty][0]) as $stopped
      | if $stopped then .[$stopped] = 0 else . end
      | if ($r | (.origin.kind? == "task-notification" or .type == "queue-operation"
                  or .type == "attachment"))
        then reduce ($r | tostring | scan("<task-id>([^<\\\\]+)</task-id>")[0]) as $c (.; .[$c] = 0)
        else . end)
    | [.[] | select(. == 1)] | length' 2>/dev/null)
  [ "${running:-0}" -gt 0 ] && tasks="  -AWAIT-"
fi
# `(O5.5 @ 95k/1M | 7d 47%/62%)`; empty parts drop out.
paren="${model}${model:+${depth:+ @ }}${depth}"
[ -n "$paren" ] && paren=" (${paren})"

if ! git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf '%s%s:%s%s%s' "$name" "$id" "$title" "$paren" "$tasks"
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
[ "${n:-0}" -gt 0 ] 2>/dev/null && dirty="  -COMMIT-"
# Committed but not pushed: ahead of the upstream (no upstream, no marker).
if [ -z "$dirty" ]; then
  ahead=$(git -C "$dir" rev-list --count @{u}..HEAD 2>/dev/null)
  [ "${ahead:-0}" -gt 0 ] 2>/dev/null && dirty="  -PUSH-"
fi
# Running work will likely change the tree further; commit once it lands.
[ -n "$tasks" ] && dirty=""

# Branch is dropped when it only repeats the worktree directory name, which
# is the usual case for `.claude/worktrees/<x>` on branch `<x>` -- printing
# both costs half the bar and says nothing.
if [ "$branch" = "$name" ] || [ "$branch" = "worktree-$name" ]; then
  printf '%s%s%s:%s%s%s%s' "$mark" "$name" "$id" "$title" "$paren" "$tasks" "$dirty"
else
  printf '%s%s%s <%s>:%s%s%s%s' "$mark" "$name" "$id" "$branch" "$title" "$paren" "$tasks" "$dirty"
fi
