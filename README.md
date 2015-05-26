## Dotfiles!

To install... **WARNING: WILL OVERWRITE CURRENT DOTFILES**

```R
cd ~/dev  # Or wherever

## Install Zsh <http://whaaat.com/content/update-shell-zsh-osx-unix>
sudo apt-get install zsh

## Install Oh-My-Zsh <https://github.com/robbyrussell/oh-my-zsh>
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

## Install all the dotfiles
git clone https://github.com/peterhurford/dotfiles.git
rm ~/.inputrc
ln -s ~/dev/dotfiles/inputrc ~/.inputrc
rm ~/.tmux.conf
ln -s ~/dev/dotfiles/tmux.conf ~/.tmux.conf
rm -rf ~/.vim
ln -s ~/dev/dotfiles/vim ~/.vim
rm ~/.vimrc
ln -s ~/dev/dotfiles/vimrc ~/.vimrc
rm ~/.zshrc
ln -s ~/dev/dotfiles/zshrc ~/.zshrc
