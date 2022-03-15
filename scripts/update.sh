#!/bin/bash
echo "Updating NVIM config..."

NVIM_CONFIG_DIR=$1
NVIM_SCRIPTS_DIR=$2
INSTALL_CHECK=$3

rm $INSTALL_CHECK

cd $NVIM_CONFIG_DIR
git pull

bash $NVIM_SCRIPTS_DIR/install.sh $@

echo "Update complete..."
sleep 1
exit 0

