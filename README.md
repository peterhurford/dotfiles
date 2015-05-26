## Dotfiles!

To install... **WARNING: WILL OVERWRITE CURRENT DOTFILES**

```R
cd ~/dev  # Or wherever
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
