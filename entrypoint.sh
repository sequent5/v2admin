#!/bin/sh
set -eu

if expr "$1" : "supervisord" 1>/dev/null; then
   echo "Start v2ray and v2ray-manager ..."
   fi
fi

exec "$@"