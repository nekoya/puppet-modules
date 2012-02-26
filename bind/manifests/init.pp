#
# bind module
#

class bind {
    $packages = ["bind-chroot", "caching-nameserver"]
    package { $packages: ensure => installed }

    service { "named":
        ensure  => running,
        enable  => true,
        require => Package[$packages],
    }

    File {
        mode    => 640,
        owner   => "root",
        group   => "named",
        notify  => Service["named"],
    }

    file { "/var/named/chroot/etc/named.conf":
        content => template("bind/etc/named.conf"),
    }

    file { "/var/named/chroot/var/named/named.ca":
        source  => "puppet:///modules/bind/var/named/named.ca",
    }
}
