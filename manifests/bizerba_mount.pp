class profile::bizerba_mount {
	# Bizerba marking equipment
	# usually only for 1,2 ERP dialog instances	
	# in cause of strange passwords, we keep user/pass in credentials file	

	$credentials = hiera(profile::bizerba_mount::credentials)
	$options = hiera(profile::bizerba_mount::options)
	$device = hiera(profile::bizerba_mount::device)

	file { '/root/credentials_bizerba':
		ensure	=> 'present',
		content	=> $credentials,
	}

	file { '/biz_data':
		ensure	=> 'directory',
	}

	mount { '/biz_data':
		name    => '/biz_data',
		atboot  => true,
		ensure  => 'mounted',
		device  => $device,
		fstype  => 'cifs',
		options => $options,
		require => [ File['/biz_data'], File['/root/credentials_bizerba'] ],
	}	
}
