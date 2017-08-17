# path
export PYENV_ROOT="/Users/peter.hurford/.pyenv"
export PATH="$PYENV_ROOT/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Applications/Postgres.app/Contents/Versions/9.6/bin:/usr/local/texlive/2017/bin/x86_64-darwin"
eval "$(pyenv init -)"

# general aliases
alias rebash='source ~/.zshrc'                        # so meta
alias findport="lsof -i TCP | grep LISTEN"
execute() { ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill }            # kills all processes that match passed string
dbkill() { ps xa | grep postgres: | grep $1 | grep -v grep | awk {'print $1'} | xargs kill }      # kill all connections to a database
tmuxkill() { tmux ls | grep -v attached | awk {'print $1'} | sed "s/://" | xargs -n 1 -I{} tmux kill-session -t {} }
v() { if [[ -z $1 ]]; then vim .; else; vim $1; fi }    # Open all files in vim or open particular file in vim

# moving aliases
x() {
  if [ $# == 0 ]; then ls -A;
    else
      if [ -f $1 ]; then; cat $1
      else ls -A $1
    fi
  fi
}

# Rails Aliases
alias mig="bundle exec rake db:migrate"
alias rtest='bundle exec ruby -I"lib:test"'
alias rc="bundle exec rails console"
alias rs="rails server"
alias bi="bundle install"

# Sinatra Aliases
sinatra() {
  open "http://localhost:4567/"
  bundle exec ruby app.rb
}

# Gitit Aliases
alias myrepos="gitit repo peterhurford"
alias compare="gitit compare"
alias commits="gitit commits"
alias branch="gitit branch"
alias mybranches="gitit branches mine"
alias gistory="gitit history"
alias prs="gitit pulls"
alias myprs="gitit pulls author:peterhurford"
alias gitgrep="gitit grep"
alias ctrlp="gitit ctrlp"

# Grep aliases
alias -g G='| grep'
alias -g P='| percol'
agl() { ag $@ | percol }

# Open everything in vim
alias -s rb=vim r=vim R=vim bash_profile=vim vimrc=vim zshrc=vim html=vim coffee=vim js=vim css=vim scss=vim jade=vim hml=vim erb=vim zsh=vim markdown=vim inputrc=vim txt=vim config=vim vim=vim

# Bind Keys
bindkey -v                                          # Vim mode for zshell
bindkey '\e[3-' delete-char                         # Magic to get CTRL+R to work
bindkey '^X' history-incremental-search-backward    # CTRL+R for zshell (mapped as CTRL+X for easier reach)
bindkey '\C-o' accept-line-and-down-history         # Do repetitive commands
bindkey '\eh' run-help                              # When your cursor is over a command, hit ESC+h to open its man page

# plugins
plugins=(autocomplete zsh-syntax-highlighting send up sudo git-aliases git-it-on hipchat rrzsh textdiff shellplyr)

# Overwrite R to not save
alias 'r'='R --no-restore'
alias 'R'='R --no-restore'

# Startup
#eval "$(tmuxifier init -)"                         # Run tmuxifier
if [ "$TMUX" = "" ]; then tmux; fi                  # Run tmux if not tmux
export ZSH=$HOME/.oh-my-zsh                         # oh-my-zsh
source $ZSH/oh-my-zsh.sh                            # Launch oh-my-zsh (important to have this beneath tmux)
source $ZSH/custom/plugins/zsh-git-prompt/zshrc.sh  # Git Prompt
source ~/.secret_zshrc                              # Source API tokens (shh secret)
GIT_ALIASES_AUTOPUSH_NEW_BRANCH=1                   # Automatically push branches when a new branch is created
GIT_ALIASES_ICDIFF=1                                # Use icdiff instead of diff
TEXTDIFF_USES_ICDIFF=1
GIT_ALIASES_SHORTER_GIT_STATUS=1                    # Use prettier git status

# Theme
PROMPT=' %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} ⌚ %{$fg_bold[red]%}%*%{$reset_color%} $ '
RPROMPT='$(git_super_status)'

# Oh-my-zsh Settings
cdpath=(~/dev)                                      # Source cdpath (autocomplete in these directories) (important to have this beneath source)
enable_correction="true"                            # command autocorrection
_comp_options+=(globdots)                           # Tab completion for dotfiles
setopt auto_cd                                      # turn on cd autocompletion
unsetopt histverify                                 # auto-submit previous history
unsetopt nomatch                                    # make rake tasks work again
unsetopt share_history                              # actually, sharing history between shells is more annoying than useful
DISABLE_AUTO_TITLE=true                             # stop letting zshell hijack the tmux window names

# Python
source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/.virtualenvs
