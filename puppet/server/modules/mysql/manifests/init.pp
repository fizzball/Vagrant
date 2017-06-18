class mysql {
     package { "mysql-server":
       ensure => present
     }
     package { "mysql-client":
       ensure => present
     }
     package { "libmysqlclient15-dev":
       ensure => present
     } 
}
