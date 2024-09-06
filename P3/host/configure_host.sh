#!/bin/sh

# reverse hostname, cut it in 2 by delimiter - and take first part
HOST_NBR=$(hostname | rev | cut -d"-" -f1)

if [ -z ${DEV} ]; then
	if [ ${HOST_NBR} == "1" ]; then
		DEV=eth1
	else
		DEV=eth0
	fi
fi

IP=30.1.1.${HOST_NBR}

/sbin/ip addr add ${IP}/24 dev ${DEV}

echo ${IP} > /root/check_ip.txt

exec /bin/sh
