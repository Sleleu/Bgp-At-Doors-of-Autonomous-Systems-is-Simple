#! /bin/sh

# reverse hostname, cut it in 2 by delimiter - and take first part
HOST_NBR=$(hostname | rev | cut -d"-" -f1)


if [ "${HOST_NBR}" = "1" ]; then
	echo "launching conf_spine.sh" > /root/script/script_launched.txt
	exec bash /root/script/conf_spine.sh
else
	echo "launching conf_leaf.sh" > /root/script/script_launched.txt
	exec bash /root/script/conf_leaf.sh
fi
