#!/bin/sh
. /static/common

# - - sanity checks - - #
if mountpint /data >/dev/null 2>&1; then
    if [ ! -f "/data/extra.conf" ]; then
        perr "/data is bind mounted but extra.conf does not exist, exiting."
    fi
fi

# - - hand over - - #
pinfo "setting permissions"
find /data -type d -exec chmod 0750 {} ';'
evalret
find /data -type f -exec chmod 0640 {} ';'
evalret

pinfo "starting named"
exec named -u named -g
