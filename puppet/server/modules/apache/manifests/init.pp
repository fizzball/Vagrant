class apache {

     package {"httpd":
       ensure => present
     }

# put web server content in /vagrant/web/src directory

     file { '/var/www/src':
         ensure => 'link',
         target => '/vagrant/web/src',
         require => Package['httpd']
     }

     file { '/etc/httpd/conf/httpd.conf':
       source => '/vagrant/server/modules/apache/files/httpd.conf',
       owner => 'root',
       group => 'root',
       require => Package['httpd']
     }

}
