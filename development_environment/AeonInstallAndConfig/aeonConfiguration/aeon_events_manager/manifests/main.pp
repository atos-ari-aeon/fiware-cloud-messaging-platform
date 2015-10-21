
  $aeon_home="/home/aeon" #to be configured according to installation folder

  $events_app_folder = "$aeon_home/aeon-events-manager"
  $events_manager_config_folder = "$aeon_home/aeon-events-manager/config"
  
  $externalIP = "$externalIP" #to be configured as needed
  
  $env = 'development'
  include aeon_conf
  
  class events_manager{
   
    class {'aeon_conf::events_manager::events_manager_brokerconnector':
      rabbit_user =>'guest',
      rabbit_pass =>'guest',
      rabbit_host =>"$externalIP",
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
  
  include 'events_manager'

  class reboot_services {
    
    exec { "npm_events_manager":
      provider => shell,
      cwd      => "$events_app_folder", 
      command  => "npm install --unsafe-perm",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Class['events_manager'],
    }
    
    file { "place_aeon_events_manager":
       path => "/etc/init.d/aeon_events",
      source =>
        "puppet:///modules/aeon_conf/aeon_events",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_events_manager'],
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
        
  }
  
  include reboot_services 
  
  
