#!/bin/sh

docker build -f host_ajung -t host_ajung .
docker build -f router_ajung -t router_ajung .
