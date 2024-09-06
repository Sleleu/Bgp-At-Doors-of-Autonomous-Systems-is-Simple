HOST_NBR=$(hostname | rev | cut -d"-" -f1)

source /root/env/leaf_${HOST_NBR}.env

env > /root/env_of_device.txt

cat > /root/script/net_script.sh <<- EOF
	/sbin/ip link add name br0 type bridge

	# Start device br0
	/sbin/ip link set dev br0 up

	# create vxlan10
	/sbin/ip link add name vxlan10 type vxlan id 10 dstport 4789

	# Start device vxlan10
	/sbin/ip link set dev vxlan10 up

	#connect interface
	brctl addif br0 vxlan10
	brctl addif br0 ${HOST_DEV}
EOF

cat  > /etc/frr/frr.conf <<- EOF
 hostname router_ajung_p3-${HOST_NBR}
 no ipv6 forwarding
 !
 interface ${ROUTER_DEV} 
  ip address ${IP}/30 
  ip ospf area 0
 !
 interface lo
  ip address ${LO}/32 
  ip ospf area 0
 !
 router bgp 1
  neighbor ${RR_IP} remote-as 1 
  neighbor ${RR_IP} update-source lo 
 !
 address-family l2vpn evpn 
  neighbor ${RR_IP} activate 
  advertise-all-vni 
 exit-address-family
 !
 router ospf
 !
exit
EOF

bash /root/script/net_script.sh

echo "net_script.sh executed" > /root/net_script.sh_check.txt

# tini -> minimal init process
# /usr/lib/frr/docker-start -> process recommended to start the container
exec /sbin/tini -- /usr/lib/frr/docker-start
