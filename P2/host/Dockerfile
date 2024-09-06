FROM		alpine:3.20

COPY		configure_host.sh .

RUN			chmod +x configure_host.sh

# ${HOST_IP} set up by .gns3
ENTRYPOINT	["./configure_host.sh"]
