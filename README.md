Kasama's NeoVIM files
==================

Introduction
------------

This repository contains the nvim configuration, including vimrc and plugins, that I use on every linux box.

Instalation
-----------

easiest way to install this is to
```bash
git clone http://github.com/Kasama/nvim ~/.config/nvim
```
the first time you open vim, it will proceed to install [Vim-Packer](https://github.com/wbthomason/packer.nvim) and then all the plugins specified in the **vimrc**.

run `:PackerSync` to ensure the latest version of all plugins
