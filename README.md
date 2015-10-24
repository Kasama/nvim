Kasama's VIM files
==================

Introduction
------------

This repository contains the vim configuration, including vimrc and plugins, that I use on every linux box.

Instalation
-----------

easiest way to install this is to
```bash
git clone http://github.com/Kasama/vim ~/.vim
```
then edit your ~/.vimrc to contain
```vimscript
:so ~/.vim/vimrc
```

the first time you open vim, it will proceed to install [Vundle](https://github.com/VundleVim/Vundle.vim) and then all the plugins specified in the **vimrc**.
