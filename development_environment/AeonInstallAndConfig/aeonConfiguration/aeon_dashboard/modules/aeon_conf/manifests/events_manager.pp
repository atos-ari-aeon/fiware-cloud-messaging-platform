class aeon_conf::events_manager{
    
    class events_manager_brokerconnector($rabbit_user,$rabbit_pass,$rabbit_host,$rabbit_port){

        file { "$::events_manager_config_folder/brokerconnector-$::env.js":
		      ensure => present,
		    }->
		    file_line { "module.exports.url $::events_manager_config_folder/brokerconnector-$::env.js":
		      path => "$::events_manager_config_folder/brokerconnector-$::env.js",  
		      line => "module.exports.url = \"amqp://$rabbit_user:$rabbit_pass@$rabbit_host:$rabbit_port\"",
		      match   => "^module.exports.url = *",
		    }
    }
    
    class events_manager_app($port){

        file { "$::events_manager_config_folder/app-$::env.js":
          ensure => present,
        }->
        file_line { "module.exports.port $::events_manager_config_folder/app-$::env.js":
          path => "$::events_manager_config_folder/app-$::env.js",  
          line => "module.exports.port = $port;",
          match   => "^module.exports.port = *",
        }
    }
    
    class events_manager_db($db_host,$db_port){

        file { "$::events_manager_config_folder/db-$::env.js":
          ensure => present,
        }->
        file_line { "module.exports.host $::events_manager_config_folder/db-$::env.js":
          path => "$::events_manager_config_folder/db-$::env.js",  
          line => "module.exports.host = \"$db_host\";",
          match   => "^module.exports.host = *",
        }
        file_line { "module.exports.port $::events_manager_config_folder/db-$::env.js":
          path => "$::events_manager_config_folder/db-$::env.js",  
          line => "module.exports.port = $db_port;",
          match   => "^module.exports.port = *",
        }

    }
}