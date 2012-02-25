#
# daemontools module
#

class daemontools {
    $module = "daemontools"
    package { "$module":
        name   => "daemontools-toaster",
        ensure => installed,
    }

    file { "/etc/init.d/svscan":
        source  => "puppet:///modules/daemontools/etc/init.d/svscan",
        mode    => 755,
        owner   => "root",
        group   => "root",
        notify  => Service[$module],
        require => Package[$module],
    }

    service { "$module":
        name    => "svscan",
        ensure  => running,
        enable  => true,
        require => File["/etc/init.d/svscan"],
    }
}
