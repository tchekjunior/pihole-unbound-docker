#!/bin/bash -e

if [ ! -e /etc/unbound/unbound.conf ]; then
    cp -fpr /data/unbound /etc/
    chown -R unbound:unbound /etc/unbound
    chmod --silent -R 644 /etc/unbound
fi;

/etc/init.d/unbound start
/s6-init