#!/usr/bin/env bash

# install pip, then use pip to install ansible
apt-get -y install python-dev python-pip
pip install ansible

# fix permissions on private key file
chmod 600 /home/vagrant/.ssh/id_rsa

# add dev-box host to known_hosts (IP is defined in Vagrantfile)
ssh-keyscan -H 192.168.11.10 >> /home/vagrant/.ssh/known_hosts
chown vagrant:vagrant /home/vagrant/.ssh/known_hosts

# create ansible hosts (inventory) file
mkdir -p /etc/ansible/
cat /vagrant/hosts >> /etc/ansible/hosts
