 class aeon_conf::frontend{
    class frontend_config($aeon_gui_host,$aeon_gui_port){

        file { "$::frontend_config_folder/config.js":
		      ensure => present,
		    }->
		    file_line { "module.exports.AEON_GUI_HOST $::frontend_config_folder/config.js":
		      path => "$::frontend_config_folder/config.js",  
		      line => "module.exports.AEON_GUI_HOST = '$aeon_gui_host';",
		      match   => "^*module.exports.AEON_GUI_HOST = *",
		    }
        file_line { "module.exports.AEON_GUI_PORT $::frontend_config_folder/config.js":
          path => "$::frontend_config_folder/config.js",  
          line => "module.exports.AEON_GUI_PORT = '$aeon_gui_port';",
          match   => "^*module.exports.AEON_GUI_PORT = *",
        }
    }
    
    class frontend_controller_config($recapcha,$rest_host,$rest_port){

        file { "$::frontend_config_folder/app/controllers/config.js":
          ensure => present,
        }->
        file_line { "RECAPTCHA_PUBLIC_KEY $::frontend_config_folder/app/controllers/config.js":
          path => "$::frontend_config_folder/app/controllers/config.js",  
          line => "RECAPTCHA_PUBLIC_KEY: '$recapcha',",
          match   => "^*RECAPTCHA_PUBLIC_KEY: *",
        }
        file_line { "AEON_HOST $::frontend_config_folder/app/controllers/config.js":
          path => "$::frontend_config_folder/app/controllers/config.js",  
          line => "AEON_HOST: '$rest_host',", # TODO check
          match   => "^*AEON_HOST: *",
        }
        file_line { "AEON_PORT $::frontend_config_folder/app/controllers/config.js":
          path => "$::frontend_config_folder/app/controllers/config.js",  
          line => "AEON_PORT: '$rest_port',", # TODO check
          match   => "^*AEON_PORT: *",
        }
    }
}
