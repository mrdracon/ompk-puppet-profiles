class profile::base {
	$snmp_community = hiera(profile::base::snmp_community)
        $snmp_network = hiera(profile::base::snmp_network)	

	# System statistics for everyone
	
	package { "sysstat":
		ensure	=> "installed",
	}
	
	service { "sysstat":
		ensure	=> running,
		enable	=> true,
		require	=> Package["sysstat"]
	}

	class { "snmp":
		ro_community	=> $snmp_community,
		ro_network	=> $snmp_network,
		agentaddress	=> [ "udp:161", "udp6:161" ],
	} 

	class { "resolv_conf":
                nameservers     => [ "1.1.9.143", "1.1.9.158", "1.1.9.159" ],
                searchpath      => "local.sosiska.ru",
        } 
}
