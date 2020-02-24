#!/bin/sh

var=$*
way=0
for i in ${var#*supervisord}; do
   if $i in proxy v2ray web; then
      if [ "$i" = "web" ]; then
         cp /opt/supervisor.d/supervisord_nginx.ini /etc/supervisor.d/
      fi
      cp /opt/supervisor.d/supervisor_$i.ini /etc/supervisor.d/
      way=`expr $way + 1`
   fi
   done

if [ $way -ge 1 ]; then
   exec "supervisord"
else
   exec "$@"
fi