# Class: aeon_conf
#
# This module manages aeon_conf
#
# Parameters: $aeon_folder
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class aeon_conf {
  
    include events_manager
    
		include frontend

    include rest   
}