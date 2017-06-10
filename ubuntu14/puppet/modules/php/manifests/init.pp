class php {
     package { "php5":
       ensure => present
     }
     package { "php5-mysql":
       ensure => present
     }
     package { "php5-dev":
       ensure => present
     }
     package { "php5-curl":
       ensure => present
     }
     package { "php5-gd":
       ensure => present
     }
     package { "php5-imagick":
       ensure => present
     }
     package { "php5-mcrypt":
       ensure => present
     }
     package { "php5-memcache":
       ensure => present
     }
     package { "php5-mhash":
       ensure => present
     }
     package { "php5-pspell":
       ensure => present
     }
     package { "php5-snmp":
       ensure => present
     }
     package { "php5-xmlrpc":
       ensure => present
     }
     package { "php5-xsl":
       ensure => present
     }
     package { "php5-cli":
       ensure => present
     }
     package { "php-pear":
       ensure => present
     }
     package { "libapache2-mod-php5":
       ensure => present,
       require => [Package[php5], Package[apache2]]
     } 
}
