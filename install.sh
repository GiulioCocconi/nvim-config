#!/bin/bash

config_dir=$1
data_dir=$2

check_file="$config_dir/.installed"

packet_dir="$data_dir/site/pack/packer/start"

if [[ -f $check_file ]]; then
		echo "Error: deps alredy installed!"
		exit 1
fi

echo "Welcome to the install script..."

echo "All done!!!"
touch $check_file 

