# path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/opt:/opt/X11/bin:/Applications/Postgres.app/Contents/Versions/9.6/bin:/usr/local/texlive/2017/bin/x86_64-darwin:/usr/local/opt/texinfo/bin:/Library/TeX/texbin"

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
plugins=(zsh-syntax-highlighting send up sudo git-aliases git-it-on rrzsh textdiff shellplyr zsh-autosuggestions)

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
export GIT_ALIASES_AUTOPUSH_NEW_BRANCH=1            # Automatically push branches when a new branch is created
export GIT_ALIASES_ICDIFF=1                         # Use icdiff instead of diff
export TEXTDIFF_USES_ICDIFF=1
export GIT_ALIASES_SHORTER_GIT_STATUS=1             # Use prettier git status
export NOT_CRAN="true"                              # For R testthat -- we are not CRAN

# Theme
PROMPT=' %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} ⌚ %{$fg_bold[red]%}%*%{$reset_color%} $   '
RPROMPT='$(git_super_status)'

# Oh-my-zsh Settings
unsetopt histverify                                 # auto-submit previous history
unsetopt nomatch                                    # make rake tasks work again
unsetopt share_history                              # actually, sharing history between shells is more annoying than useful
DISABLE_AUTO_TITLE=true                             # stop letting zshell hijack the tmux window names
autoload -U promptinit && promptinit                # load autocomplete
autoload -U compinit compdef && compinit
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0162'
setopt autocd                                       # turn on cd autocompletion
cdpath=(~/dev)                                      # Source cdpath (autocomplete in these directories) (important to have this beneath source)
_comp_options+=(globdots)                           # Tab completion for dotfiles
setopt autopushd pushdminus pushdsilent             # stuff with pushd
setopt pushdtohome pushdignoredups
setopt extendedglob                                 # Do not require a leading '.' in a filename to be matched explicitly
setopt globdots
setopt shwordsplit                                  # Causes field splitting to be performed on unquoted parameter expansions
setopt automenu                                     # Automatically use menu completion after the second consecutive request for completion
setopt cdablevars                                   # If the argument to a cd command (or an implied cd with the AUTO_CD option set)
                                                    # is not a directory, and does not begin with a slash, try to expand the
                                                    # expression as if it were preceded by a '~'
setopt listpacked                                   # Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths
setopt alwaystoend                                  # If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word
setopt correct                                      # Try to correct the spelling of commands
setopt rmstarsilent                                 # Disable annoying confirm

# Python
source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/.virtualenvs
