if [[ -f ~/.ps1_list ]]; then
	source ~/.ps1_list
fi
if [[ -f ~/.bash_functions ]]; then
	source ~/.bash_functions
fi

if [[ $(whoami) = 'root' ]] ;then
	export SUDOBIN=''
	source /home/tiago/.bash_aliases_root
else
	export SUDOBIN=$(which sudo)
fi #End of verify if root

##With sudo
alias apta="$SUDOBIN apt"
alias aptl="$SUDOBIN apt install"
alias apts="$SUDOBIN apt search"
alias docker="$SUDOBIN docker"
alias docker-compose="$SUDOBIN docker-compose"

alias las="ls -lah --color=auto"
alias ls="ls --color=auto"

if [[ -d /ongoing ]]; then
	alias ongoing='cd /ongoing'
fi
if [[ -d /ongoing ]]; then
	alias projects='cd /projects'
fi


