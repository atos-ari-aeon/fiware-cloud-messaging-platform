# Class: aeon_mongodb
#
# This module manages aeon_mongodb
#
# Parameters: mongodb_version
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class aeon_mongodb($mongodb_version) {
  
    file { [ "/data", "/data/db"]:
       ensure => "directory",
       owner => $id ,
       group => $id
    }
    
    exec { "apt_key_add":
      command => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
      path    => ["/bin", "/usr/bin"],
      require => File["/data","/data/db"],
    }
    
    file { '/etc/apt/sources.list.d/10gen.list':
      ensure => present,
    }->
    file_line { 'Append a line to /etc/apt/sources.list.d/10gen.list':
      path => '/etc/apt/sources.list.d/10gen.list',  
      line => 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen',
      require => Exec["apt_key_add"],
    }
        
    exec { "aptGetUpdateEarlyMongo":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"],
        require => File_line["Append a line to /etc/apt/sources.list.d/10gen.list"]
    }

    exec { "preinstallmongo":
      command => "sudo apt-get install -f -y ",
      path => ["/bin", "/usr/bin"],
      require => Exec["aptGetUpdateEarlyMongo"]
    }
    
    exec { "install_early_mongodb":
      command => "sudo apt-get -f install mongodb-10gen=$mongodb_version",
      path    => ["/bin", "/usr/bin"],
      require => Exec["preinstallmongo"],
      logoutput => on_failure
    }
    
    service { 'mongodb':
			ensure => running,
			restart => '/usr/bin/mongod --dbpath=/data/db /usr/sbin/service ssh reload',
			require => Exec["install_early_mongodb"],
		}

}
