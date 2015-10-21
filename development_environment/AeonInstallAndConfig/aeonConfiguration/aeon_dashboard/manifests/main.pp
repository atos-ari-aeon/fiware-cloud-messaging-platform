
  $aeon_home="/home/aeon" #to be configured according to installation folder

  $frontend_config_folder = "$aeon_home/aeon-dashboard"
  $frontend_app_folder = "$aeon_home/aeon-dashboard"
  
  $externalIP = "$externalIP" #to be configured as needed
  
  include aeon_conf
  
 
  class frontend{
    class {'::aeon_conf::frontend::frontend_config':
      aeon_gui_host => "$externalIP",
      aeon_gui_port=> '8000',
    }
    
    class {'::aeon_conf::frontend::frontend_controller_config':
      recapcha => '6LfpRe4SAAAAAK55U_PfaYxvogR-jHGRMJQp8ArW',
      rest_host => "$externalIP",
      rest_port => '3000',
    }
  }
    
  include 'frontend'
 
  class reboot_services {
    
    exec { "npm_frontend":
      provider => shell,
      cwd      => "$frontend_app_folder", 
      command  => "npm install",
      path     => ['/bin', '/usr/bin', '/usr/local/bin'],
      require  => Class['frontend'],
    }
            
    file { "place_aeon_frontend":
       path => "/etc/init.d/aeon_frontend",
      source =>
        "puppet:///modules/aeon_conf/aeon_frontend",
      ensure => 'file',
      mode => 'a+x',
      require  => Exec['npm_frontend'],
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
        
  }
  
  include reboot_services 
  
  
