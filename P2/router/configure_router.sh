#!/bin/sh

if [ ${LOCAL_NBR} -eq 1 ]; then
	REMOTE_NBR=2
else
	REMOTE_NBR=1
fi

/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up

/sbin/ip addr add 10.1.1.${LOCAL_NBR}/24 dev eth0

if [ ${MULTICAST} -eq 1 ]; then
	/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
else
	/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.${REMOTE_NBR} local 10.1.1.${LOCAL_NBR} dstport 4789
fi

/sbin/ip addr add 20.1.1.${LOCAL_NBR}/24 dev vxlan10
brctl addif br0 eth1
brctl addif br0 vxlan10

/sbin/ip link set dev vxlan10 up

# tini -> minimal init process
# /usr/lib/frr/docker-start -> process recommended to start the container
exec /sbin/tini -- /usr/lib/frr/docker-start
