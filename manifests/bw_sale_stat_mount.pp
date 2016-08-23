class profile::bw_sale_stat_mount {
        # Fileshare for bw guys, so they can load flat-files(csv) into OBP using application servers
        # for both BI dialog instances
        # we keep user/pass in credentials file

        $credentials = hiera(profile::bw_sale_stat_mount::credentials)
        $options = hiera(profile::bw_sale_stat_mount::options)
        $device = hiera(profile::bw_sale_stat_mount::device)

	notice("device = $device")
	notice("options = $options")

        file { '/root/credentials_bw_sale_stat':
                ensure  => 'present',
                content => $credentials,
        }

        file { '/usr/sap/bw_sale_stat':
                ensure  => 'directory',
        }

        mount { '/usr/sap/bw_sale_stat':
                name    => '/usr/sap/bw_sale_stat',
                atboot  => true,
                ensure  => 'mounted',
                device  => $device,
                fstype  => 'cifs',
                options => $options,
                require => [ File['/usr/sap/bw_sale_stat'], File['/root/credentials_bw_sale_stat'] ],
        }

}
