
	$aeon_home="/home/aeon" #to be configured according to installation folder

	$rest_config_folder = "$aeon_home/aeon-api/config"
	$rest_app_folder = "$aeon_home/aeon-api"
	
  $internalIP = "192.168.33.12" #to be configured as needed
  $externalIP = "192.168.33.12" #to be configured as needed
  
  $env = 'development'
  include aeon_conf
  
    
  class rest{
    class {'::aeon_conf::rest::rest_brokerconnector':
      rabbit_user => 'guest',
      rabbit_pass => 'guest',
      rabbit_host => "$internalIP",
      rabbit_port => 5672,
      aeon_gui_port => 3000,   
    }
    
    class {'::aeon_conf::rest::rest_db':
      db_host =>'127.0.0.1',
      db_port => 27017,
    }
    
    class {'::aeon_conf::rest::rest_app':
      rest_proxy_protocol => 'http',
      rest_proxy_host => "$externalIP",
      rest_proxy_port => 3000,
      rest_internal_host => "$internalIP",
      rest_internal_port => 3000,
      rest_internal_secret => 'default should be changed',
      socket_host => "$internalIP",
      socket_port => 7789,
      gui_protocol => 'http',
      gui_host => "$externalIP",
      gui_port => 8000,
    } 
  }    
  
  include 'rest'
  
  class reboot_services {
    
    exec { "npm_rest":
      provider    => shell,
      cwd         => "$rest_app_folder", 
      command     => "npm install --unsafe-perm",
      environment => ["HOME=${$aeon_home}"],
      path        => ['/bin', '/usr/bin', '/usr/local/bin','/usr/local/sbin','/sbin','/usr/sbin'],
      require     => Class['rest'],
    }
   
    
    file { "place_aeon_rest":
       path => "/etc/init.d/aeon_rest",
      source =>
        "puppet:///modules/aeon_conf/aeon_rest",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_rest'],
    }
    
    exec { "update_rc_rest":
      provider => shell,
      cwd      => "$rest_app_folder", 
      command  => "update-rc.d aeon_rest defaults",
      path     => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      refreshonly => true,
      require  => File["place_aeon_rest"],
    }
    
    exec { "reboot_rest":
      provider => shell,
      cwd      => "$rest_app_folder", 
      command  => "service aeon_rest restart",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Exec['update_rc_rest'],
    }
        
  }
  
  include reboot_services 
  
  
