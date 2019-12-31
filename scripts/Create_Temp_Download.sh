#!/bin/bash
#Add to crontab:
#@reboot /folder_to_this_script/runonboot.sh
#

FILE_LOG=.runonboot.txt
TIME_RUN=$(date +"%Y_%m_%d__%H-%M-%S")
#Create /tmp/_temp_Downloads/
if [ ! -d /tmp/_temp_Downloads ]; then
 mkdir -p /tmp/_temp_Downloads
 mkdir -p /tmp/_temp_Downloads/nginx_temp_projects
 chmod 777 -R /tmp/_temp_Downloads
 chown tiago:tiago -R /tmp/_temp_Downloads
fi

if [ ! -d /tmp/_temp_Downloads/nginx_temp_projects ]; then
  mkdir -p /tmp/_temp_Downloads/nginx_temp_projects
  echo -e "ALERTA!!!\nTodos os arquivos contidos nesta pasta (/tmp/_temp_Downloads/nginx_temp_projects) serao deletados ao reiniciar o computador" > /tmp/_temp_Downloads/nginx_temp_projects/TUDO_SERA_DELETADO_AO_REINICIAR.txt
  chmod -R 777 /tmp/_temp_Downloads/nginx_temp_projects
  chown -R tiago:tiago /tmp/_temp_Downloads/nginx_temp_projects
fi

if [ ! -f $FILE_LOG ]; then
echo -e "$TIME_RUN run from /apps/tgoscripts/scripts/runonboot.sh user:$(whoami) creating">/tmp/_temp_Downloads/$FILE_LOG;else
echo -e "$TIME_RUN run from /apps/tgoscripts/scripts/runonboot.sh user:$(whoami)">>/tmp/_temp_Downloads/$FILE_LOG
fi

chmod 777 -R /tmp/_temp_Downloads
chown tiago:tiago -R /tmp/_temp_Downloads


#MySQL/Maria
#sudo service mysql start

############################
/apps/tiago_scripts/allthis/RUN*
