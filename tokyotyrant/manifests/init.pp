#
# tokyo tyrant module
#

class tokyotyrant {
    $module = "tokyotyrant"
    define tokyotyrant_config() {
        file { "$name":
            mode    => 755,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/$module/$fqdn/$name",
                "puppet:///files/$module/$domain/$name",
                "puppet:///files/$module/default/$name",
                "puppet:///modules/$module/$name",
            ],
            require => Package[$module],
            notify  => Service["ttservctl"],
        }
    }
    tokyotyrant_config { "/etc/rc.d/init.d/ttservctl": }

    package { "tokyotyrant": ensure => installed }

    exec { "/sbin/chkconfig --add ttservctl":
        user    => "root",
        unless  => "/sbin/chkconfig --list ttservctl",
        require => File["/etc/rc.d/init.d/ttservctl"],
    }

    service { "ttservctl":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => File["/etc/rc.d/init.d/ttservctl"],
    }
}
