#
# keepalived module
#

class keepalived {
    $module = "keepalived"

    $packages = [
        "ipvsadm",
        "keepalived",
    ]

    define keepalived_sysconfig() {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/$module/$fqdn/$name",
                "puppet:///files/$module/$domain/$name",
                "puppet:///files/$module/default/$name",
                "puppet:///modules/$module/$name",
            ],
            require => Package[$packages],
            notify  => Service[$module],
        }
    }
    keepalived_sysconfig { "/etc/sysconfig/keepalived": }

    define keepalived_config($file="keepalived/etc/keepalived/keepalived.conf") {
        if (!$keepalived_state)    { $keepalived_state     = "BACKUP" }
        if (!$keepalived_priority) { $keepalived_priority  = "50" }
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
            require => Package[$packages],
            notify  => Service[$module],
        }
    }
    keepalived_config { "/etc/keepalived/keepalived.conf": }

    package { $packages: ensure => installed }

    service { "$module":
        ensure  => running,
        enable  => true,
        require => Package[$packages],
    }

    define real_server($lvs_ip="") {
        file { "/etc/sysconfig/network-scripts/ifcfg-${name}":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template("keepalived/etc/sysconfig/network-scripts/ifcfg-lvs"),
        }
    }
}
