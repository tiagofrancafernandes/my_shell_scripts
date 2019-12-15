#!/bin/bash

cd $(pwd) && cd ..
BIN_PATH=$(pwd)/bin
#echo -e "Adding $BIN_PATH to PATH of $USER."
#echo -e "To make it permanent, add this to .bashrc file."
export PATH="$BIN_PATH:$PATH"
cd $OLDPWD
