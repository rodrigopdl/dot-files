#These are my configuration files for:

* Vim
* Tmux
* Oh my zsh

# Basic package installation

```
cd
git clone https://github.com/rodrigopdl/dot-files.git my-dot-files-dir
ln -s my-dot-files-dir/.zshrc .zshrc
ln -s my-dot-files-dir/.tmux.conf .tmux.conf
ln -s my-dot-files-dir/vim .vim
ln -s my-dot-files-dir/vim/.vimrc .vimrc
cd .vim
git submodule init
git submodule update
```

# Special considerations

If submodules init fails, run vim/add-submodules-script.sh first.
