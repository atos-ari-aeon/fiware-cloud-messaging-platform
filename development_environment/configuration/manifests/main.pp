
	$frontend_config_folder = "/vagrant/aeon-platform/src/platform/frontend"
	$events_manager_config_folder = "/vagrant/aeon-platform/src/platform/events-manager/config"
	$rest_config_folder = "/vagrant/aeon-platform/src/platform/rest/config"
	
	$frontend_app_folder = "/vagrant/aeon-platform/src/platform/frontend"
	$events_app_folder = "/vagrant/aeon-platform/src/platform/events-manager"
	$rest_app_folder = "/vagrant/aeon-platform/src/platform/rest"
	
  $internalIP = '192.168.33.10' 
  $externalIP = '192.168.33.10' 
  # internalIP

  $env = 'development'
  include aeon_conf
  
  class events_manager{
   
    class {'aeon_conf::events_manager::events_manager_brokerconnector':
      rabbit_user =>'guest',
      rabbit_pass =>'guest',
      rabbit_host =>"$internalIP",
      rabbit_port =>5672,
    }
    
    class {'::aeon_conf::events_manager::events_manager_app':
      port => 7789
    }
    
    class {'::aeon_conf::events_manager::events_manager_db':
      db_host  => "127.0.0.1" ,
      db_port  => 27017,
    }
  }
  
  class frontend{
    class {'::aeon_conf::frontend::frontend_config':
      aeon_gui_host => "$internalIP",
      aeon_gui_port=> '8000',
    }
    
    class {'::aeon_conf::frontend::frontend_controller_config':
      recapcha => '6LfpRe4SAAAAAK55U_PfaYxvogR-jHGRMJQp8ArW',
      rest_host => "$internalIP",
      rest_port => '3000',
    }
  }
  
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
      rest_proxy_host => "$externalIP", #externalIP
      rest_proxy_port => 3000,
      rest_internal_host => "$internalIP",
      rest_internal_port => 3000,
      rest_internal_secret => 'default should be changed',
      socket_host => "$internalIP",
      socket_port => 7789,
      gui_protocol => 'http',
      gui_host => "$externalIP", #externalIP
      gui_port => 8000,
    } 
  }    
  
  include 'events_manager'
  include 'frontend'
  include 'rest'
  
  class reboot_services {
    
    exec { "npm_frontend":
      provider => shell,
      cwd      => "$frontend_app_folder", 
      command  => "npm install",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Class['frontend'],
    }
    
    exec { "npm_rest":
      provider    => shell,
      cwd         => "$rest_app_folder", 
      command     => "npm install",
      environment => ['HOME=/home/vagrant'],
      path        => ['/bin', '/usr/bin', '/usr/local/bin'],
      require     => Class['rest'],
    }
      
     exec { "npm_events_manager":
      provider => shell,
      cwd      => "$events_app_folder", 
      command  => "npm install",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Class['events_manager'],
    }
    
    file { "place_aeon_events_manager":
       path => "/etc/init.d/aeon_events",
      source =>
        "puppet:///modules/aeon_conf/aeon_events",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_frontend','npm_events_manager','npm_rest'],
    }
    
    exec { "update_rc_events_manager":
      provider => shell,
      cwd      => "$events_app_folder", 
      command  => "update-rc.d aeon_events defaults",
      path     => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      refreshonly => true,
      require  => File["place_aeon_events_manager"],
    }
    
    exec { "reboot_events_manager":
      provider => shell,
      cwd      => "$events_app_folder", 
      command  => "service aeon_events restart",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Exec['update_rc_events_manager'],
    }
        
    file { "place_aeon_frontend":
       path => "/etc/init.d/aeon_frontend",
      source =>
        "puppet:///modules/aeon_conf/aeon_frontend",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_frontend','npm_events_manager','npm_rest'],
    }
    
    exec { "update_rc_frontend":
      provider => shell,
      cwd      => "$frontend_app_folder", 
      command  => "update-rc.d aeon_frontend defaults",
      path     => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      refreshonly => true,
      require  => File["place_aeon_frontend"],
    }
    
    exec { "reboot_frontend":
      provider => shell,
      cwd      => "$frontend_app_folder", 
      command  => "service aeon_frontend restart",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Exec['update_rc_frontend'],
    }
    
    file { "place_aeon_rest":
       path => "/etc/init.d/aeon_rest",
      source =>
        "puppet:///modules/aeon_conf/aeon_rest",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_frontend','npm_events_manager','npm_rest'],
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
  
  
