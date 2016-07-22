class profile::base {
	# System statistics for everyone
	
	package { "sysstat":
		ensure	=> "installed",
	}
	
	service { "sysstat":
		ensure	=> running,
		enable	=> true,
		require	=> Package["sysstat"]
	}  
}
