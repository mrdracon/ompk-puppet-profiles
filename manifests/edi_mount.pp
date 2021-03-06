class profile::edi_mount {
	# EDI - Exite, www.edi.su. For ERP dialog systems
	# TDDESADV share - exchange with trade houses	

	$device_cinbox = hiera(profile::edi_mount::device_cinbox)
	$device_exchangedata = hiera(profile::edi_mount::device_exchangedata)
	$device_saprecadv = hiera(profile::edi_mount::device_saprecadv)
	$device_recadvarchive = hiera(profile::edi_mount::device_recadvarchive)
	
	$device_tddesadv = hiera(profile::edi_mount::device_tddesadv)
	
	$device_skbkontur = hiera(profile::edi_mount::device_skbkontur)

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

	file { [ '/data/cinbox' , '/exchange/data' , '/data/saprecadv', '/data/recadvarchive', '/data/tddesadv', '/exchange/SKBKontur' ]:
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

	mount { '/data/tddesadv':
                        name    => '/data/tddesadv',
                        atboot  => true,
                        ensure  => 'mounted',
                        device  => $device_tddesadv,
                        fstype  => 'cifs',
                        options => $options,
                        require => [ File['/data/tddesadv'], File['/root/credentials_edi'] ],
        }

	mount { '/exchange/SKBKontur':
                        name    => '/exchange/SKBKontur',
                        atboot  => true,
                        ensure  => 'mounted',
                        device  => $device_skbkontur,
                        fstype  => 'cifs',
                        options => $options,
                        require => [ File['/exchange/SKBKontur'], File['/root/credentials_edi'] ],
        }
}       
