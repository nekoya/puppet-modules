#
# network module
#

class network {
    $module = "network"
    define network_file($file="network/etc/sysconfig/network") {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
        }
    }
    network_file { "/etc/sysconfig/network": }

    define resolver_config($file="network/etc/resolv.conf") {
        $module = "network"
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
        }
    }
    resolver_config { "/etc/resolv.conf": }

    service { "$module":
        ensure    => running,
        enable    => true,
        hasstatus => true,
    }
}

class network::bonding {
    $module = "network"
    file { "/etc/modprobe.d/bonding":
        mode    => 644,
        owner   => "root",
        group   => "root",
        content => template("$module/etc/modprobe.d/bonding"),
    }

    file { "/etc/sysconfig/network-scripts/ifcfg-bond0":
        mode    => 644,
        owner   => "root",
        group   => "root",
        content => template("$module/etc/sysconfig/network-scripts/ifcfg-bond0"),
    }

    define network_file() {
        file { "/etc/sysconfig/network-scripts/ifcfg-${name}":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template("$module/etc/sysconfig/network-scripts/ifcfg-ethX"),
            require => [
                File["/etc/sysconfig/network-scripts/ifcfg-bond0"],
                File["/etc/modprobe.d/bonding"],
            ],
            notify  => Service["$module"],
        }
    }
    network_file { "eth0": }
    network_file { "eth1": }
}
