#!/bin/bash
BKP_DIR=$(pwd)/backup_files
SCRIPT_DIR=$(pwd)/SCRIPTS
ACTION_BIN="$(which cp)"

if [[ ! -z $1 ]]; then
    if [[ "$1" = "link" ]]; then
        ACTION_BIN="$(which ln) -s"
    fi
    if [[ "$1" = "--help" ]]; then
        echo -e "
        link    | To files be symlinks. Optional.
        --help  | To get help
        "
    fi
fi

if [[ ! -d $BKP_DIR ]]; then
    mkdir -p $BKP_DIR
fi

if [[ -f $SCRIPT_DIR/.bashrc ]]; then
    if [[ -f $HOME/.bashrc ]]; then
        if [[ ! -L $HOME/.bashrc ]]; then
            cp $HOME/.bashrc $BKP_DIR/.bashrc
        fi
        rm $HOME/.bashrc
        $ACTION_BIN $SCRIPT_DIR/.bashrc $HOME/.bashrc
    else
        $ACTION_BIN $SCRIPT_DIR/.bashrc $HOME/.bashrc
    fi
fi


if [[ -f $SCRIPT_DIR/.bash_aliases ]]; then
    if [[ -f $HOME/.bash_aliases ]]; then
        if [[ ! -L $HOME/.bash_aliases ]]; then
            cp $HOME/.bash_aliases $BKP_DIR/.bash_aliases
        fi
        rm $HOME/.bash_aliases
        $ACTION_BIN $SCRIPT_DIR/.bash_aliases $HOME/.bash_aliases
    else
        $ACTION_BIN $SCRIPT_DIR/.bash_aliases $HOME/.bash_aliases
    fi
fi


if [[ -f $SCRIPT_DIR/.bash_aliases_root ]]; then
    if [[ -f $HOME/.bash_aliases_root ]]; then
        if [[ ! -L $HOME/.bash_aliases_root ]]; then
            cp $HOME/.bash_aliases_root $BKP_DIR/.bash_aliases_root
        fi
        rm $HOME/.bash_aliases_root
        $ACTION_BIN $SCRIPT_DIR/.bash_aliases_root $HOME/.bash_aliases_root
    else
        $ACTION_BIN $SCRIPT_DIR/.bash_aliases_root $HOME/.bash_aliases_root
    fi
fi


if [[ -f $SCRIPT_DIR/.ps1_list ]]; then
    if [[ -f $HOME/.ps1_list ]]; then
        if [[ ! -L $HOME/.ps1_list ]]; then
            cp $HOME/.ps1_list $BKP_DIR/.ps1_list
        fi
        rm $HOME/.ps1_list
        $ACTION_BIN $SCRIPT_DIR/.ps1_list $HOME/.ps1_list
    else
        $ACTION_BIN $SCRIPT_DIR/.ps1_list $HOME/.ps1_list
    fi
fi


if [[ -f $SCRIPT_DIR/.bash_functions ]]; then
    if [[ -f $HOME/.bash_functions ]]; then
        if [[ ! -L $HOME/.bash_functions ]]; then
            cp $HOME/.bash_functions $BKP_DIR/.bash_functions
        fi
        rm $HOME/.bash_functions
        $ACTION_BIN $SCRIPT_DIR/.bash_functions $HOME/.bash_functions
    else
        $ACTION_BIN $SCRIPT_DIR/.bash_functions $HOME/.bash_functions
    fi
fi

