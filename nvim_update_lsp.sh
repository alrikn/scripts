#!/bin/bash
basepath=$(dirname $(readlink -f $0))

data_dir=$basepath/data

input_file="$data_dir/nvim_lsp.lua"
output_file="$HOME/.config/nvim/lua/configs/lspconfig.lua"
target_line="-- Danis cool config"
awk -v target="$target_line" '{
  if ($0 == target) exit;  # Exit when the target line is found
  print;                  # Print lines before the target
}' "$output_file" | cat - "$input_file" > temp.txt
rm -f "$output_file"
mv temp.txt "$output_file"
