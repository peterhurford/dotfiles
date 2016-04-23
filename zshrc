# path
export PATH="bin:/Users/peterhurford/.rvm/gems/ruby-2.2.2/:/Applications/Postgres.app/Contents/Versions/9.4/bin:/Users/peterhurford/.rvm/gems/ruby-2.2.2@global/bin:/Users/peterhurford/.rvm/rubies/ruby-2.2.2/bin:/Users/peterhurford/.Renv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin"
export GHC_DOT_APP="/Applications/ghc-7.10.1.app"   # Run GHCI
if [ -d "$GHC_DOT_APP" ]; then
   export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# general aliases
alias rebash='source ~/.zshrc'                        # so meta
alias findport="lsof -i TCP | grep LISTEN"
execute() { ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill }            # kills all processes that match passed string
dbkill() { ps xa | grep postgres: | grep $1 | grep -v grep | awk {'print $1'} | xargs kill }      # kill all connections to a database
title() { echo -ne "\033]0;"$*"\007" }
tms() { tmuxifier load-session $1 }                     # Load tmuxifier sessions
alias frig='$(thefuck $(fc -ln -1))'                    # TheFuck plugin <https://github.com/nvbn/thefuck>

# Languages!
kona() {
  echo "Booting Kona REPL via rlwrap ~/dev/kona/k"
  rlwrap ~/dev/kona/k
}
haskell() {
  echo "Booting Haskell REPL via ghci"
  ghci
}
clojure() {
  echo "Booting Clojure REPL via lein repl"
  lein repl
}

v() { if [[ -z $1 ]]; then vim .; else; vim $1; fi }    # Open all files in vim or open particular file in vim

# Toggl (https://github.com/drobertadams/toggl-cli)
alias toggl="~/dev/toggl-cli/toggl.py"
tag() {
  if [ $# == 2 ]; then
    toggl start "$1" "@$2"
  elif [ $# == 0 ]; then
    toggl now
  elif [ $1 == 'w' ]; then
    open 'https://www.toggl.com/app/#reports/weekly'
  elif [ $1 == 'stop' ]; then
    toggl stop
  elif [ $1 == 't' ]; then
    open 'http://www.toggl.com/app/timer'
  else
    toggl start "$1" "@$1"
  fi
}

# Beeminder (https://github.com/lydgate/bmndr)
alias bmndr="~/dev/staging/bmndr/bmndr"
beelist() {
  clear
  date
  bmndr
}
beeadd() {  # beeadd 1 fruits <comment>
  if [ $2 == "smoothie" ]; then
    bmndr fruits 1
    bmndr creatine 0.5
    bmndr flax 0.5
    bmndr veggies 1
    bmndr dairy 1
  else
    bmndr $2 $1 $3
  fi
  sleep 8
  clear
  bmndr refresh $2
  echo "Loading..."
  sleep 4
  beelist
}
beeopen() {
  local baseurl="https://www.beeminder.com"
  if [[ $# == 0 ]]; then; open "$baseurl/dashboard"
  else; open "$baseurl/peterhurford/$1"
  fi
}

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

# Global Aliases
alias -g zrc='~/.zshrc'

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

# Fix RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# plugins
plugins=(autocomplete zsh-syntax-highlighting send up sudo git-aliases git-it-on hipchat rrzsh analytics-tactical)

# Overwrite R to not save
alias 'r'='R --no-restore'
alias 'R'='R --no-restore'

# Startup
#eval "$(tmuxifier init -)"                         # Run tmuxifier
tmux                                                # Tmux
export ZSH=$HOME/.oh-my-zsh                         # oh-my-zsh
source $ZSH/oh-my-zsh.sh                            # Launch oh-my-zsh (important to have this beneath tmux)
source $ZSH/custom/plugins/zsh-git-prompt/zshrc.sh  # Git Prompt
source ~/.secret_zshrc                              # Source API tokens (shh secret)
GIT_ALIASES_AUTOPUSH_NEW_BRANCH=1                   # Automatically push branches when a new branch is created
GIT_ALIASES_ICDIFF=1                                # Use icdiff instead of diff
GIT_ALIASES_SHORTER_GIT_STATUS=1                    # Use prettier git status

# Theme
PROMPT=' %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} ⌚ %{$fg_bold[red]%}%*%{$reset_color%} $ '
RPROMPT='$(git_super_status)'

# Oh-my-zsh Settings
cdpath=(~/dev ~/dev/avant ~/dev/avant-basic)        # Source cdpath (autocomplete in these directories) (important to have this beneath source)
enable_correction="true"                            # command autocorrection
_comp_options+=(globdots)                           # Tab completion for dotfiles
#compdef _c vim                                      # Autocomplete for vim
setopt auto_cd                                      # turn on cd autocompletion
unsetopt histverify                                 # auto-submit previous history
unsetopt nomatch                                    # make rake tasks work again
unsetopt share_history                              # actually, sharing history between shells is more annoying than useful
DISABLE_AUTO_TITLE=true                             # stop letting zshell hijack the tmux window names

# added by travis gem
[ -f /Users/peterhurford/.travis/travis.sh ] && source /Users/peterhurford/.travis/travis.sh
