class mail {

     package { "postfix":
       ensure => present
     }
     package { "mailutils":
       ensure => present
     }
     exec { 'autostartmail':
       command => '/usr/sbin/update-rc.d postfix defaults',
       require => Package['postfix']
     } 
}
