#!/bin/bash

#set the DNS as 8.8.8.8
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf
service systemd-resolved restart


#update the /etc/hosts entry
# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts


IFNAME=enp0s8
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

cat >> /etc/hosts <<EOF
192.168.5.10  k8s-master
192.168.5.21  k8s-worker-1
192.168.5.22  k8s-worker-2
EOF
