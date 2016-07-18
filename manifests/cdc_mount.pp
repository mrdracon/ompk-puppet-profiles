class profile::cdc_mount {
        # CDC share, for ERP and GIS Optimum integration (logistics and truck routing)
        # for both PI dialog instances
        # we keep user/pass in credentials file

        $credentials = hiera(profile::cdc_mount::credentials)
        $options = hiera(profile::cdc_mount::options)
        $device = hiera(profile::cdc_mount::device)

        file { '/root/credentials_cdc':
                ensure  => 'present',
                content => $credentials,
        }

        file { '/cdc':
                ensure  => 'directory',
        }

        mount { '/cdc':
                name    => '/cdc',
                atboot  => 'true',
                ensure  => 'mounted',
                device  => $device,
                fstype  => 'cifs',
                options => $options,
                require => [ File['/cdc'], File['/root/credentials_cdc'] ],
        }

}
