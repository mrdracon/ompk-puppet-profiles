class profile::edi_mount {
	# EDI - Exite, www.edi.su. For ERP dialog systems

	$device_cinbox = hiera(profile::edi_mount::device_cinbox)
	$device_exchangedata = hiera(profile::edi_mount::device_exchangedata)
	$device_saprecadv = hiera(profile::edi_mount::device_saprecadv)
	$device_recadvarchive = hiera(profile::edi_mount::device_recadvarchive)
	$options = hiera(profile::edi_mount::options)	
	$credentials = hiera(profile::edi_mount::credentials)

	file { '/root/credentials_edi':
                ensure  => 'present',
                content => $credentials,
        }

	file { '/data':
		ensure  => 'directory',
		owner	=> 'oepadm'
	}

	file { '/exchange':
		ensure  => 'directory',
	}

	file { [ '/data/cinbox' , '/exchange/data' , '/data/saprecadv', '/data/recadvarchive' ]:
		ensure => 'directory',
		require	=> File['/exchange'],
	}

	mount { '/data/cinbox':
			name    => '/data/cinbox',
			atboot  => true,
			ensure  => 'mounted',
			device  => $device_cinbox,
			fstype  => 'cifs',
			options => $options,
			require => [ File['/data/cinbox'], File['/root/credentials_edi'] ],
	}

	mount { '/exchange/data':
			name    => '/exchange/data',
			atboot  => true,
			ensure  => 'mounted',
			device  => $device_exchangedata,
			fstype  => 'cifs',
			options => $options,
			require => [ File['/exchange/data'], File['/root/credentials_edi'] ],
	}

	mount { '/data/saprecadv':
			name    => '/data/saprecadv',
			atboot  => true,
			ensure  => 'mounted',
			device  => $device_saprecadv,
			fstype  => 'cifs',
			options => $options,
			require => [ File['/data/saprecadv'], File['/root/credentials_edi'] ],
	}

	mount { '/data/recadvarchive':
			name    => '/data/recadvarchive',
			atboot  => true,
			ensure  => 'mounted',
			device  => $device_recadvarchive,
			fstype  => 'cifs',
			options => $options,
			require => [ File['/data/recadvarchive'], File['/root/credentials_edi'] ],
	}	
}       
