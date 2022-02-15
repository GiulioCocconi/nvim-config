#!/bin/bash

config_dir=$1
data_dir=$2

check_file="$config_dir/.installed"

packet_dir="$data_dir/site/pack/packer/start"

function install_nvm() {
	echo "Installing nvm..."
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	echo "nvm installed!"
}

if [[ -f $check_file ]]; then
		echo "Error: deps alredy installed!"
		exit 1
fi

echo "Welcome to the install script..."

if [[ ! -d $NVM_DIR ]] && install_nvm

echo "All done!!!"
touch $check_file 

