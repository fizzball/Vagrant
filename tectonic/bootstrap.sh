#!/usr/bin/env bash

#yum update -y
cp /vagrant/bashrc /home/vagrant/.bashrc
# install aws cli tools
curl -O https://bootstrap.pypa.io/get-pip.py
python /home/vagrant/get-pip.py --user
pip install awscli --upgrade --user
