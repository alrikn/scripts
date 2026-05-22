#!/usr/bin/env bash

source rc.sh .

packages="git
		vim
		tree
		zsh
        valgrind
        build-essential
		flameshot
		playerctl
		htop
		btop
		gobuster
		ffuf
		nmap
		netcat-openbsd
		hydra
		steghide
		stegsnow
		openvpn
		sl
		clangd
		adb
		bear
        cmake
		qt5ct"

if command -v dnf &> /dev/null; then
	echo "Using dnf"
	sudo dnf install $packages
elif command -v apt &> /dev/null; then
	echo "Using apt"
	sudo apt install $packages
else
	echo "No supported package manager found"
fi

#Dark qt5
cp data/qt5ct.conf .config/qt5ct/qt5ct.conf
echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.profile

#Rustc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

./config_flameshot.sh
./rice_vim.sh
echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' | /bin/zsh

#NVchad
PATH="$HOME/.cargo/bin:$PATH"
cargo install --git https://github.com/MordechaiHadad/bob.git
bob use latest && sudo ln -s $HOME/.local/share/bob/nvim-bin/nvim /bin/nvim
./rice_nvim.sh

mkdir -p ~/.local/share/fonts
cp data/AgaveNerdFont-Regular.ttf ~/.local/share/fonts
