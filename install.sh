#!/bin/bash

echo "Installing..."

# download dotfiles
git clone https://github.com/rskull/dotfiles > /dev/null 2>&1

if [ ! -e dotfiles ]; then
  mv dotfiles .dotfiles
fi

# make symbric link
function make_symlink() {
  for file in ~/.dotfiles/conf/* ; do
    if [ -f $file ]; then
      ln -s $file ~/.${file##*/}
    fi
  done
}

# vim
ln -s ~/.dotfiles/vim .vim

# NeoBundle
curl -sS https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh > /dev/null 2>&1

# PHP Complete
DICT_DIR=~/.vim/dict
DICT_PHP=php.dict
 
if [ ! -e $DICT_DIR/$DICT_PHP ]; then
  mkdir -p $DICT_DIR
  php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);' | sort > $DICT_DIR/$DICT_PHP | echo > /dev/null 2>&1
fi

make_symlink

echo "Complate setup dotfiles!!"
