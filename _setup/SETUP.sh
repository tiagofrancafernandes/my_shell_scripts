#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR && cd ..
TGO_SCRIPTS_PATH=$(pwd)
SETUP_PATH=$(pwd)/_setup
RCFILE=$HOME/.bashrc
SOURCE_THIS=$SETUP_PATH/add_to_path.sh



TO_BASHRC="\n##TGO_SCRIPTS\nexport TGO_SCRIPTS_PATH=$TGO_SCRIPTS_PATH\nif [ -f $SOURCE_THIS ] ; then\n source $SOURCE_THIS ; \nfi\n##TGO_SCRIPTS\n"

if [ -f $RCFILE ] ; then
echo -e "$TO_BASHRC" >> $RCFILE;
else
echo -e "Has no file $RCFILE";
fi