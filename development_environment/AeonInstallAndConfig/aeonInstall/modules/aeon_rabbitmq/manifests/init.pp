# Class: aeon_rabbitmq
#
# This module manages aeon_rabbitmq
#
# Parameters: rabbitmq_version
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#class { 'aeon_rabbitmq':
#    rabbitmq_version => '3.1.2',
#  }
#
class aeon_rabbitmq ($rabbitmq_version) {
    
    file { '/etc/apt/sources.list':
      ensure => present,
    }->
    file_line { 'Append a line to /etc/apt/sources.list':
      path => '/etc/apt/sources.list',  
      line => 'deb http://packages.erlang-solutions.com/ubuntu trusty contrib',
    }
    
    exec { "wget_erlang":
      command => "wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc",
      onlyif  => "test ! -f /home/$id/erlang_solutions.asc",
      path    => ["/bin", "/usr/bin"],
      require => [Package["wget"],File_line['Append a line to /etc/apt/sources.list']]
    }
    
    exec { "dpkg_erlang":
      command => "sudo apt-key add erlang_solutions.asc",
      path => ["/bin", "/usr/bin"],
      logoutput => "on_failure",
      require => Exec["wget_erlang"]
    }
    
    exec { "apt_get_update_erlang":
      command => "sudo apt-get update",
      logoutput => "on_failure",
      path    => ["/bin", "/usr/bin","/sbin","/usr/sbin"],
      require => Exec["dpkg_erlang"]
    }
        
    exec { "install_erlang":
      command => "sudo apt-get install -y erlang",
      path => ["/bin", "/usr/bin"],
      require => Exec["apt_get_update_erlang"]
    }
    
    exec { "preinstallerlang":
      command => "sudo apt-get install -f",
      path => ["/bin", "/usr/bin"],
      require => Exec["install_erlang"]
    }
    
    exec { "apt_get_update_erlang_nox":
      command => "sudo apt-get update",
      logoutput => "on_failure",
      path    => ["/bin", "/usr/bin","/sbin","/usr/sbin"],
      require => Exec["preinstallerlang"]
    }
        
    exec { "install_erlang_nox":
      command => "sudo apt-get install -y erlang-nox",
      path => ["/bin", "/usr/bin"],
      require => Exec["apt_get_update_erlang_nox"]
    }
    
    exec { "preinstallerlang_nox":
      command => "sudo apt-get install -f",
      path => ["/bin", "/usr/bin"],
      require => Exec["install_erlang_nox"]
    }
      
    exec { "wget_rabbitmq":
      command => "wget  https://www.rabbitmq.com/releases/rabbitmq-server/v${rabbitmq_version}/rabbitmq-server_${rabbitmq_version}-1_all.deb -P /home/aeon",
      path => ["/bin", "/usr/bin"],
      require => [Exec["preinstallerlang"],Exec["aptGetUpdate"], Package["git"], Package["curl"], Package["g++"]]
    }
    
    exec { "install_dpkg_rabbitmq":
      command => "sudo dpkg -i /home/aeon/rabbitmq-server_${rabbitmq_version}-1_all.deb",
      path => ["/bin", "/usr/bin"],
      require => Exec["wget_rabbitmq"]
    }
    
    exec { "enable_rabbitmq_management":
      command => "sudo rabbitmq-plugins enable rabbitmq_management",
      path => ["/bin", "/usr/bin"],
      logoutput => "on_failure",
      require => Exec["install_dpkg_rabbitmq"]
    }

    exec { "restart-rabbitmq":
      command => "service rabbitmq-server restart",
      path    => ["/bin", "/usr/bin"],
      require => Exec["enable_rabbitmq_management"]
    }
}
