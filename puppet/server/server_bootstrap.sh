#!/usr/bin/env bash

function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

PACKAGE1=puppetserver

# setup hosts entries
chmod +x /vagrant/etchosts.sh
/vagrant/etchosts.sh remove client.box
/vagrant/etchosts.sh remove web.box
/vagrant/etchosts.sh add client.box	1.1.1.112
/vagrant/etchosts.sh add web.box	1.1.1.113

# install puppet server

if isinstalled $PACKAGE1; 
   then 
	echo "$PACKAGE1 already installed"
	cp /vagrant/server/puppet.conf /etc/puppetlabs/puppet/puppet.conf
	cp -R /vagrant/server/modules /etc/puppetlabs/code/environments/production/
	cp -R /vagrant/server/manifests /etc/puppetlabs/code/environments/production/
   else 
	echo **** installing NTP ****
	timedatectl set-timezone Australia/Sydney
	yum -y install ntp
	ntpdate pool.ntp.org
	cp /vagrant/ntp.conf /etc/ntp.conf
	systemctl restart ntpd.service
	systemctl enable ntpd.service
	echo **** installing Puppet Server ****
	rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
	yum -y install puppetserver
	cp /vagrant/puppet.conf /etc/puppetlabs/puppet/puppet.conf
	cp -R /vagrant/server/modules /etc/puppetlabs/code/environments/production/
	cp -R /vagrant/server/manifests /etc/puppetlabs/code/environments/production/
	systemctl enable puppetserver
	echo **** launching Puppet Server ****
	systemctl start puppetserver 
	echo **** installing Modules ****
	/opt/puppetlabs/puppet/bin/puppet module install bashtoni-timezone --version 1.0.0 
	echo **** done *** ;
fi
