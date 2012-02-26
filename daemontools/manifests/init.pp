#
# daemontools module
#

class daemontools::install {
    package { "daemontools":
        name   => "daemontools-toaster",
        ensure => installed,
    }

    file { "/etc/init.d/svscan":
        source  => "puppet:///modules/daemontools/etc/init.d/svscan",
        mode    => 755,
        owner   => "root",
        group   => "root",
        notify  => Class["daemontools::service"],
        require => Package[$module],
    }
}

class daemontools::service {
    service { "daemontools":
        name    => "svscan",
        ensure  => running,
        enable  => true,
        require => Class["daemontools::install"],
    }
}

class daemontools {
    include daemontools::install
    include daemontools::service
}
