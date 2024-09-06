FROM		frrouting/frr:v8.4.0

COPY		configure_router.sh .

RUN			chmod +x configure_router.sh

RUN 		sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons && \
    		sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons && \
    		sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons

# ${LOCAL_NBR} and ${MULTICAST} set up by .gns3
ENTRYPOINT	["./configure_router.sh"]
