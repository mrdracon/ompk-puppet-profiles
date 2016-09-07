class profile::td1c_mount {
	# SAP CIFG mount from QNAP 1.1.6.4, for SAP -> 1c exchange

        $credentials = hiera(profile::td1c_mount::credentials)
        $options = hiera(profile::td1c_mount::options)
        $device = hiera(profile::td1c_mount::device)

        file { '/root/credentials_td1c':
                ensure  => 'present',
                content => $credentials,
        }

        file { '/obmen_td1c':
                ensure  => 'directory',
        }

        mount { '/obmen_td1c':
                name    => '/obmen_td1c',
                atboot  => true,
                ensure  => 'mounted',
                device  => $device,
                fstype  => 'cifs',
                options => $options,
                require => [ File['/obmen_td1c'], File['/root/credentials_td1c'] ],
        }

}
