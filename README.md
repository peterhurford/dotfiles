## Dotfiles!

To install... **WARNING: WILL OVERWRITE CURRENT DOTFILES**

```R
cd ~/dev  # Or wherever

## Install Zsh <http://whaaat.com/content/update-shell-zsh-osx-unix>
sudo apt-get install zsh

## Install Oh-My-Zsh <https://github.com/robbyrussell/oh-my-zsh>
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

## Install Oh-My-Zsh Plugins
git clone https://github.com/peterhurford/git-aliases.zsh.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/peterhurford/git-it-on.zsh.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/peterhurford/rrzsh.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/robertzk/send.zsh.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/peterhurford/up.zsh.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins

## Install Vim Plugins
git clone https://github.com/jcfaria/Vim-R-plugin.git ~/.vim/bundle
git clone https://github.com/corntrace/bufexplorer.git ~/.vim/bundle
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle
git clone https://github.com/motemen/git-vim.git ~/.vim/bundle
git clone https://github.com/peterhurford/macroutils.vim.git ~/.vim/bundle
git clone https://github.com/kien/rainbow_parentheses.vim.git ~/.vim/bundle
git clone https://github.com/danro/rename.vim.git ~/.vim/bundle
git clone https://github.com/peterhurford/send.vim.git ~/.vim/bundle
git clone https://github.com/ervandew/supertab.git ~/.vim/bundle
git clone https://github.com/peterhurford/swapquote.vim.git ~/.vim/bundle
git clone https://github.com/Townk/vim-autoclose.git ~/.vim/bundle
git clone https://github.com/kchmck/vim-coffee-script.git ~/.vim/bundle
git clone https://github.com/tpope/vim-commentary.git ~/.vim/bundle
git clone https://github.com/Lokaltog/vim-easymotion.git ~/.vim/bundle
git clone https://github.com/justincampbell/vim-eighties.git ~/.vim/bundle
git clone https://github.com/tpope/vim-endwise.git ~/.vim/bundle
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle
git clone https://github.com/digitaltoad/vim-jade.git ~/.vim/bundle
git clone https://github.com/derekwyatt/vim-scala.git ~/.vim/bundle
git clone https://github.com/fweep/vim-zsh-path-completion.git ~/.vim/bundle

## Install all the dotfiles
git clone https://github.com/peterhurford/dotfiles.git
rm ~/.inputrc
ln -s ~/dev/dotfiles/inputrc ~/.inputrc
rm ~/.tmux.conf
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf
rm ~/.vimrc
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
rm ~/.zshrc
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
