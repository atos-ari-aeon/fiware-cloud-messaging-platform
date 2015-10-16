
  class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
  }
  
  class othertools {
    package { "git":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "vim-common":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "curl":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }
    
    package { "wget":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "htop":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "g++":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }
  }
  
  include apt_update
  include othertools
   
  class { 'aeon_mongodb':
    mongodb_version => '2.4.8',
  }
  
  class { 'aeon_nodejs':
    nodejs_version => '0.10',
  }
  
  class { 'aeon_rabbitmq':
    rabbitmq_version => '3.1.2',

  }
   

