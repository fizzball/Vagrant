#!/usr/bin/env bash

#yum update -y
cp /vagrant/bashrc /home/vagrant/.bashrc

#install mesos
# Install a few utility tools
yum install -y tar wget git

# Fetch the Apache Maven repo file.
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

# Install the EPEL repo so that we can pull in 'libserf-1' as part of our
# subversion install below.
yum install -y epel-release

# 'Mesos > 0.21.0' requires 'subversion > 1.8' devel package,
# which is not available in the default repositories.
# Create a WANdisco SVN repo file to install the correct version:
bash -c 'cat > /etc/yum.repos.d/wandisco-svn.repo <<EOF
[WANdiscoSVN]
name=WANdisco SVN Repo 1.9
enabled=1
baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/\$basearch/
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
EOF'

# Parts of Mesos require systemd in order to operate. However, Mesos
# only supports versions of systemd that contain the 'Delegate' flag.
# This flag was first introduced in 'systemd version 218', which is
# lower than the default version installed by centos. Luckily, centos
# 7.1 has a patched 'systemd < 218' that contains the 'Delegate' flag.
# Explicity update systemd to this patched version.
yum update systemd

# Install essential development tools.
yum groupinstall -y "Development Tools"

# Install other Mesos dependencies.
yum install -y apache-maven python-devel python-six python-virtualenv java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel

wget http://www.apache.org/dist/mesos/1.3.0/mesos-1.3.0.tar.gz
tar -zxf mesos-1.3.0.tar.gz
cd /home/vagrant/mesos-1.3.0

# Configure and build.
mkdir build
cd build
../configure
make

# Start Mesos master (ensure work directory exists and has proper permissions).
./bin/mesos-master.sh --ip=127.0.0.1 --work_dir=/var/lib/mesos

# Start Mesos agent (ensure work directory exists and has proper permissions).
./bin/mesos-agent.sh --master=127.0.0.1:5050 --work_dir=/var/lib/mesos

# Visit the Mesos web page.
# http://127.0.0.1:5050

# Run C++ framework (exits after successfully running some tasks).
./src/test-framework --master=127.0.0.1:5050

# Run Java framework (exits after successfully running some tasks).
./src/examples/java/test-framework 127.0.0.1:5050

# Run Python framework (exits after successfully running some tasks).
./src/examples/python/test-framework 127.0.0.1:5050
