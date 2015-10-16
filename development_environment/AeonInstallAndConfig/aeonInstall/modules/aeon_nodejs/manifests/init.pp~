# Class: aeon_nodejs
#
# This module manages aeon_nodejs
#
# Parameters: nodejs_version
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class aeon_nodejs ($nodejs_version) {
  
    exec { "git_clone_n":
      command => "git clone https://github.com/visionmedia/n.git /home/vagrant/n",
      onlyif          => "test ! -d /home/vagrant/n",
      path => ["/bin", "/usr/bin"],
      require => [Exec["aptGetUpdate"], Package["git"], Package["curl"], Package["g++"]]
    }
  
    exec { "install_n":
      command => "make install",
      path => ["/bin", "/usr/bin"],
      cwd => "/home/vagrant/n",
      require => Exec["git_clone_n"]
    }
  
    exec { "install_node":
      command => "n ${nodejs_version}",
      path => ["/bin", "/usr/bin", "/usr/local/bin"],  
      require => [Exec["git_clone_n"], Exec["install_n"]]
    }
    
    exec { "install_forever":
      command => "npm install forever -g",
      path => ["/bin", "/usr/bin", "/usr/local/bin"],  
      require => [Exec["install_node"]]
    }
  }
  
	

