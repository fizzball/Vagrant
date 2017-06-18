#!/usr/bin/env bash

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

PACKAGE1=puppet-agent
PACKAGE2=docker

# setup hosts entries
chmod +x /vagrant/etchosts.sh
/vagrant/etchosts.sh remove puppet
/vagrant/etchosts.sh remove web.box
/vagrant/etchosts.sh add puppet		1.1.1.111
/vagrant/etchosts.sh add web.box	1.1.1.113

# install puppet agent

if isinstalled $PACKAGE1; 
   then 
	echo "$PACKAGE1 already installed";
   else 
	rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
	yum -y install puppet-agent
	/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true ;
fi

if isinstalled $PACKAGE2; 
   then 
	echo "$PACKAGE2 already installed";
   else 
	yum install -y yum-utils device-mapper-persistent-data lvm2
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-17.03.1.ce-1.el7.centos.x86_64.rpm
	cp /vagrant/daemon.json /etc/docker/daemon.json
	systemctl start docker
	docker run hello-world ;
fi



