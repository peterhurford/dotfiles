## Dotfiles!

To install... **WARNING: WILL OVERWRITE CURRENT DOTFILES**

```
## Install Zsh <http://whaaat.com/content/update-shell-zsh-osx-unix>
sudo apt-get install zsh  # Already installed on Mac OSX

## Install Oh-My-Zsh <https://github.com/robbyrussell/oh-my-zsh>
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sudo sh

## Install Tmux
sudo apt-get install tmux # or brew install tmux for Mac OSX

## Install ag
apt-get install silversearcher-ag # or brew install the_silver_searcher for Mac OSX

## Install Oh-My-Zsh Plugins
cd ~/.oh-my-zsh/custom/plugins
sudo git clone https://github.com/peterhurford/git-aliases.zsh.git
sudo git clone https://github.com/peterhurford/git-it-on.zsh.git
sudo git clone https://github.com/peterhurford/rrzsh.git
sudo git clone https://github.com/robertzk/send.zsh.git
sudo git clone https://github.com/peterhurford/up.zsh.git
sudo git clone https://github.com/peterhurford/shellplyr.git
sudo git clone https://github.com/olivierverdier/zsh-git-prompt.git
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
sudo git clone https://github.com/peterhurford/textdiff.zsh.git
sudo git clone https://github.com/zsh-users/zsh-autosuggestions
sudo mv send.zsh send
sudo mv up.zsh up
sudo mv textdiff.zsh textdiff
sudo mv git-it-on.zsh git-it-on
sudo mv git-aliases.zsh git-aliases

## Install icdiff <http://www.jefftk.com/icdiff>
curl -s https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.7.3/icdiff \
  | sudo tee /usr/local/bin/icdiff > /dev/null \
    && sudo chmod ugo+rx /usr/local/bin/icdiff

## Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## Install Vim Plugins
cd ~/.vim/bundle
git clone https://github.com/corntrace/bufexplorer.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/motemen/git-vim.git
git clone https://github.com/peterhurford/macroutils.vim.git
git clone https://github.com/danro/rename.vim.git
git clone https://github.com/peterhurford/send.vim.git
git clone https://github.com/ervandew/supertab.git
git clone https://github.com/peterhurford/swapquote.vim.git
git clone https://github.com/Townk/vim-autoclose.git
git clone https://github.com/kchmck/vim-coffee-script.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/Lokaltog/vim-easymotion.git
git clone https://github.com/justincampbell/vim-eighties.git
git clone https://github.com/tpope/vim-endwise.git
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/digitaltoad/vim-jade.git
git clone https://github.com/derekwyatt/vim-scala.git
git clone https://github.com/fweep/vim-zsh-path-completion.git
git clone https://github.com/peterhurford/vimflow

## Install all the dotfiles
mkdir ~/dev
cd ~/dev
git clone https://github.com/peterhurford/dotfiles.git
rm ~/.inputrc
ln -s ~/dev/dotfiles/inputrc ~/.inputrc
rm ~/.tmux.conf
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf
rm ~/.vimrc
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
rm ~/.zshrc
touch ~/.secret_zshrc # A secret file to store your exported tokens.
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
rm ~/.bash_profile
ln -s ~/dev/dotfiles/bash_profile ~/.bash_profile

## Initialize
tmux
zsh
