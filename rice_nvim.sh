#!/bin/bash
basepath=$(dirname $(readlink -f $0))

data_dir=$basepath/data

ping -c 1 github.com && rm -rf ~/.local/share/nvim ~/.cache/nvim ~/.config/nvim

git clone https://github.com/NvChad/starter ~/.config/nvim/ || echo $(cd ~/.config/nvim && git pull origin main)

cat $data_dir/nvim_config.lua > ~/.config/nvim/lua/options.lua

mkdir -p ~/.config/nvim/plugin
cp $data_dir/42header.vim ~/.config/nvim/plugin/.

sed -i '/theme =/c\    theme = "flexoki",' ~/.config/nvim/lua/chadrc.lua

# add lsp config
$basepath/nvim_update_lsp.sh
