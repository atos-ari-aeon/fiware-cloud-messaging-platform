class aeon_conf::rest{ 

    class rest_brokerconnector($rabbit_user,$rabbit_pass,$rabbit_host,$rabbit_port,$aeon_gui_port){
    
		    file { "$::rest_config_folder/brokerconnector-$::env.js":
          ensure => present,
        }->
        file_line { "module.exports.url $::rest_config_folder/brokerconnector-$::env.js":
          path => "$::rest_config_folder/brokerconnector-$::env.js",  
          line => "module.exports.url = \"amqp://$rabbit_user:$rabbit_pass@$rabbit_host:$rabbit_port\"",
          match   => "^module.exports.url = *",
        }

    }
    
    class rest_db($db_host,$db_port){

        file { "$::rest_config_folder/db-$::env.js":
          ensure => present,
        }->
        file_line { "module.exports.host $::rest_config_folder/db-$::env.js":
          path => "$::rest_config_folder/db-$::env.js",  
          line => "module.exports.host = \"$db_host\";",
          match   => "^module.exports.host = *",
        }
        file_line { "module.exports.port $::rest_config_folder/db-$::env.js":
          path => "$::rest_config_folder/db-$::env.js",  
          line => "module.exports.port = $db_port;",
          match   => "^module.exports.port = *",
        }
    }
    
    class rest_app($rest_proxy_protocol,$rest_proxy_host,$rest_proxy_port,$rest_internal_host,
      $rest_internal_port,$rest_internal_secret,$socket_host,$socket_port,$gui_protocol,
      $gui_host,$gui_port
    ){

        #proxy
        file { "$::rest_config_folder/app-$::env.js":
          ensure => present,
        }->
        file_line { "module.exports.protocol $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.protocol = '$rest_proxy_protocol';",
          match   => "^module.exports.protocol = *",
        }
        file_line { "module.exports.extHost $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.extHost = '$rest_proxy_host';",
          match   => "^module.exports.extHost = *",
        }
        file_line { "module.exports.extPort $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.extPort = $rest_proxy_port;",
          match   => "^module.exports.extPort = *",
        }
        file_line { "module.exports.secret $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.secret = \"$rest_internal_secret\";",
          match   => "^module.exports.secret = *",
        }
        file_line { "module.exports.host $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.host = '$rest_internal_host';",
          match   => "^module.exports.host = *",
        }
        file_line { "module.exports.port $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.port = $rest_internal_port;",
          match   => "^module.exports.port = *",
        }
        file_line { "module.exports.socket_server_host $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.socket_server_host = '$socket_host';",
          match   => "^module.exports.socket_server_host = *",
        }
        file_line { "module.exports.socket_server_port $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.socket_server_port = $socket_port;",
          match   => "^module.exports.socket_server_port = *",
        }
        file_line { "module.exports.protocolGUI $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.protocolGUI = '$gui_protocol';",
          match   => "^module.exports.protocolGUI = *",
        }
        file_line { "module.exports.extHostGUI $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.extHostGUI = '$gui_host';",
          match   => "^module.exports.extHostGUI = *",
        }
        file_line { "module.exports.extPortGUI $::rest_config_folder/app-$::env.js":
          path => "$::rest_config_folder/app-$::env.js",  
          line => "module.exports.extPortGUI = $gui_port;",
          match   => "^module.exports.extPortGUI = *",
        }
    }
}  