#!/bin/bash

config_dir=$1
data_dir=$2

check_file="$config_dir/.installed"

ready=1

function check_command() {
	if ! command -v $1 &> /dev/null; then
		echo "[error] $1 not found, please install it yourself"
		ready=0
	fi
}

if [[ -f $check_file ]]; then
	echo "[error] deps alredy installed!"
	exit 1
fi

echo "Welcome to the install script..."

echo "Installing deps..."

check_command "python3"
check_command "rustc"

[[ $ready != 1 ]] && exit 1

pip install pynvim
cargo install broot

echo "All done!!!"
touch $check_file

