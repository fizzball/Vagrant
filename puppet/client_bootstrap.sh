#!/usr/bin/env bash

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

PACKAGE1=puppet-agent

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
