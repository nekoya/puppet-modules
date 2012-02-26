#
# sysctl module
#

class sysctl {
    $module = "sysctl"

    define sysctl_config($file="sysctl/etc/sysctl.conf") {
        if !$sysctl_ip_forward { $sysctl_ip_forward = 0 }
        if !$sysctl_arp_ignore { $sysctl_arp_ignore = 0 }
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
        }
    }
    sysctl_config { "/etc/sysctl.conf": }

    package { "procps": ensure => installed }

    exec { "sysctl_p":
        command     => "sysctl -p",
        subscribe   => File["/etc/sysctl.conf"],
        refreshonly => true,
    }
}
