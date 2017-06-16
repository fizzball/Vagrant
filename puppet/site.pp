  file {'/tmp/example-ip':                                            # resource type file and filename
     ensure  => present,                                               # make sure it exists
     mode    => '0644',                                                # file permissions
     content => "Here is my Vagrant host IP Address: ${ipaddress_enp0s8}.\n",  # note the ipaddress_eth0 fact
}


node 'client' {    

  class { 'timezone':
     region   => 'Australia',
     locality => 'Sydney',
  }
}

node 'web' {    

  class { 'timezone':
     region   => 'Australia',
     locality => 'Sydney',
  }

   class httpd {

     package {"httpd":
       ensure => present
     }

# put web server content in /vagrant/src directory

     file { '/var/www/src':
         ensure => 'link',
         target => '/vagrant/src',
         require => Package['httpd']
     }

     file { '/etc/httpd/conf/httpd.conf':
       source => '/vagrant/httpd.conf',
       owner => 'root',
       group => 'root',
       require => Package['httpd']
     }
}

node 'default' {}    # applies to nodes that aren't defined

