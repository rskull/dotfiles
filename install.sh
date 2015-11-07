#!/bin/bash

echo "Installing..."

# download dotfiles
git clone https://github.com/rskull/dotfiles > /dev/null 2>&1

if [ ! -e .dotfiles ]; then
  mv dotfiles .dotfiles
fi

# make symbric link
function make_symlink() {
  for file in ~/.dotfiles/conf/* ; do
    if [ -f $file ] && [ ! -e .$file ]; then
      ln -s $file ~/.${file##*/}
    fi
  done
}

# tmux
mkdir .tmux
git clone https://github.com/erikw/tmux-powerline.git .tmux/tmux-powerline > /dev/null 2>&1

# vim
ln -s ~/.dotfiles/vim .vim
mkdir ~/.vim/backup ~/.vim/dict

# NeoBundle
curl -sS https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh > /dev/null 2>&1

# PHP Complete
DICT_DIR=~/.vim/dict
DICT_PHP=php.dict
 
if [ ! -e $DICT_DIR/$DICT_PHP ]; then
  php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);' | sort > $DICT_DIR/$DICT_PHP | echo > /dev/null 2>&1
fi

make_symlink

echo "Complate setup dotfiles!!"
