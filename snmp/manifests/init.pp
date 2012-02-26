#
# snmp module
#

class snmp {
    $module = "snmp"

    $packages = [
        "net-snmp",
        "net-snmp-libs",
        "net-snmp-utils",
        "sysstat",
    ]

    define snmp_config() {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/$fqdn/$module/$name",
                "puppet:///files/$domain/$module/$name",
                "puppet:///files/default/$module/$name",
                "puppet:///modules/$module/$name",
            ],
            require => Package[$packages],
            notify  => Service["snmpd"],
        }
    }
    snmp_config {
        [
            "/etc/sysconfig/snmpd.options",
            "/etc/snmp/snmpd.conf",
        ]:
    }

    package { $packages: ensure => installed }

    service { "snmpd":
        ensure    => running,
        enable    => true,
        require   => Package[$packages],
    }
}
