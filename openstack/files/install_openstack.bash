#!/bin/bash
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network
sudo yum install -y centos-release-openstack-rocky
yum-config-manager --enable openstack-rocky
sudo yum update -y
sudo yum install -y openstack-packstack
sudo packstack --allinone
