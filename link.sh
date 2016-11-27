#!/bin/bash

# make symbric link
function make_symlink() {
  for file in ~/.dotfiles/conf/* ; do
    if [ -f $file ] && [ ! -e .$file ]; then
      ln -s $file ~/.${file##*/}
    fi
  done
}

make_symlink
