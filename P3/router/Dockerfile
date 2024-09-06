FROM		frrouting/frr:v8.4.0

COPY 		conf/vtysh.conf /etc/frr/vtysh.conf

COPY		script/	/root/script
COPY		env/	/root/env

RUN			chmod +x /root/script/conf_router.sh
RUN			chmod +x /root/script/conf_leaf.sh
RUN			chmod +x /root/script/conf_spine.sh

RUN			chmod +r /root/env/spine.env
RUN			chmod +r /root/env/leaf_2.env
RUN			chmod +r /root/env/leaf_3.env
RUN			chmod +r /root/env/leaf_4.env

RUN 		sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons && \
    		sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons && \
    		sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons

ENTRYPOINT	["/root/script/conf_router.sh"]
