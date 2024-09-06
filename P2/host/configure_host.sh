#!/bin/sh

/sbin/ip addr add 30.1.1.${HOST_IP}/24 dev eth1

exec /bin/sh
