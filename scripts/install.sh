#!/bin/bash
echo

config_dir=$1
scripts_dir=$2
check_file=$3

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

echo "Welcome to the install/upgrade script..."
echo
echo "Installing deps..."

check_command "python3"
check_command "pip"
check_command "node"
check_command "yarn"
check_command "perl"
check_command "vifm"

[[ $ready != 1 ]] && exit 1

pip install pynvim

echo "All done!!!"
touch $check_file
