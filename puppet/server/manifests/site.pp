# create a new run stage to ensure certain modules are included first
stage { 'pre':
  before => Stage['main']
}

# add the baseconfig module to the new 'pre' run stage
class { 'baseconfig':
  stage => 'pre'
}

# set defaults for file ownership/permissions
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}


node 'client' {    

  class { 'timezone':
     region   => 'Australia',
     locality => 'Sydney',
  }
}

node 'web' {    

  include baseconfig, apache

  class { 'timezone':
     region   => 'Australia',
     locality => 'Sydney',
  }
}

node 'default' {}    # applies to nodes that aren't defined

