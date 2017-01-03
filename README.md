Kasama's NeoVIM files
==================

Introduction
------------

This repository contains the nvim configuration, including vimrc and plugins, that I use on every linux box.

Instalation
-----------

easiest way to install this is to
```bash
git clone http://github.com/Kasama/nvim ~/nvim
```
then edit your ~/.config/nvim/init.vim to contain
```vimscript
:so ~/.config/nvim/init.vim
```
or symlink ~/.config/nvim to ~/nvim

the first time you open vim, it will proceed to install [Vim-Plug](https://github.com/junegunn/vim-plug) and then all the plugins specified in the **vimrc**.
