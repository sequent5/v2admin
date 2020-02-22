#!/bin/sh
set -eu

if expr "$1" : "supervisord" 1>/dev/null; then
   if [ ! -f /etc/v2ray/config.json ] || [ ! -f /opt/v2ray-manager/config/admin.properties ] || || [ ! -f /opt/v2ray-manager/config/proxy.properties ]; then
   echo "Missing profile ..."
   exit 1
   else
   echo "Start v2ray and v2ray-manager ..."
   fi
fi

mv /etc/v2ray/config.json /etc/v2ray/config.json.bak \

exec "$@"