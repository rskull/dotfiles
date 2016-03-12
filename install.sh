#!/bin/bash

echo "Installing..."

# download dotfiles
git clone https://github.com/rskull/dotfiles > /dev/null 2>&1

if [ ! -e .dotfiles ]; then
  mv dotfiles .dotfiles
fi

# tmux
mkdir .tmux
git clone https://github.com/erikw/tmux-powerline.git .tmux/tmux-powerline > /dev/null 2>&1

# vim
ln -s ~/.dotfiles/vim .vim
mkdir ~/.vim/backup ~/.vim/dict

# Dein
curl -sS https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh installer.sh ~/.vim/dein

rm installer.sh

# PHP Complete
DICT_DIR=~/.vim/dict
DICT_PHP=php.dict
 
if [ ! -e $DICT_DIR/$DICT_PHP ]; then
  php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);' | sort > $DICT_DIR/$DICT_PHP | echo > /dev/null 2>&1
fi

sh .dotfiles/link.sh

echo "Complate setup dotfiles!!"
