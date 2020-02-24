#!/bin/bash

var=($*)
way=0
array=(proxy web v2ray)
for i in ${var[*]}; do
   [[ ${array[@]/${i}/} != ${array[@]} ]] && cp /opt/supervisor.d/supervisord_$i.ini /etc/supervisor.d/ && way=`expr $way + 1`
   if [ "$i" = "web" ]; then
      cp /opt/supervisor.d/supervisord_nginx.ini /etc/supervisor.d/
   fi
done

if [ $way -ge 1 ]; then
   exec "supervisord"
else
   exec "$@"
fi