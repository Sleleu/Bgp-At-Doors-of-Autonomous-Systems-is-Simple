#!/bin/sh

docker build --no-cache -f host_tsantoni -t host_tsantoni .
docker build --no-cache -f router_tsantoni -t router_tsantoni .