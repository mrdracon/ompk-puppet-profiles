class profile::archiving_mount {
	# Mounting 1.1.6.7 QNAP NFS share	

        $options = hiera(profile::archiving_mount::options)
        $device = hiera(profile::archiving_mount::device)

	$symlink = hiera(profile::archiving_mount::symlink)
	$symlink_target = hiera(profile::archiving_mount::symlink_target)
	$symlink_owner = hiera(profile::archiving_mount::symlink_owner)
	$symlink_group = hiera(profile::archiving_mount::symlink_group)

        file { '/archiving':
                ensure  => 'directory',
        }

        mount { '/archiving':
                name    => '/archiving',
                atboot  => true,
                ensure  => 'mounted',
                device  => $device,
                fstype  => 'nfs',
                options => $options,
                require => File['/archiving'],
        }

	# Sap systems by default place arvihved data on local disk.
	#  We use this link so SAP dialog systems cam place all their archived data on QNAP
	file { $symlink:
		ensure	=> link,
		target	=> $symlink_target,
		owner	=> $symlink_owner,
		group	=> $symlink_group,
	}
}
