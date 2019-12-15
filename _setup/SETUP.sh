#!/bin/bash

cd $(pwd) && cd ..
SETUP_PATH=$(pwd)/_setup
RCFILE=$HOME/.bashrc
SOURCE_THIS=$SETUP_PATH/add_to_path.sh


TO_BASHRC="\nif [ -f $SOURCE_THIS ] ; then\n source $SOURCE_THIS ; \nfi\n"

if [ -f $RCFILE ] ; then
echo -e "$TO_BASHRC" >> $RCFILE;
else
echo -e "Has no file $RCFILE";
fi
