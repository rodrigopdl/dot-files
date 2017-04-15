#These are my configuration files for:

* Vim
* Tmux
* Oh my zsh
* Git

# Basic package installation

```
cd
git clone https://github.com/rodrigopdl/dot-files.git my-dot-files-dir
ln -s my-dot-files-dir/.zshrc .zshrc
ln -s my-dot-files-dir/.tmux.conf .tmux.conf
ln -s my-dot-files-dir/vim .vim
ln -s my-dot-files-dir/vim/.vimrc .vimrc
ln -s my-dot-files-dir/.gitconfig .gitconfig
ln -s my-dot-files-dir/.agignore .agignore
ln -s my-dot-files-dir/.ackrc .ackrc
Open vim and run :PlugInstall
```

# Install ctags related things

```
brew install ctags (or use the package manager you like/have)
gem install gem-browse
gem install gem-ctags
gem ctags
```

# Iterm notes

* Font: 12pt Hack antialised
* Theme gruvbox
