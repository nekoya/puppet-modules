#
# ntp module
#

class ntp {
    $module = "ntp"

    $ntp_servers = [
        "ntp.nict.jp",
        "ntp.nc.u-tokyo.ac.jp",
        "clock.nc.fukuoka-u.ac.jp",
        "clock.tl.fukuoka-u.ac.jp",
        "time.nuri.net",
    ]

    define ntp_conf_file($file="ntp/etc/ntp.conf") {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
            notify  => Service["ntpd"],
        }
    }
    ntp_conf_file { "/etc/ntp.conf": }

    service { "ntpd":
        ensure    => running,
        enable    => true,
        require   => Package[$module],
    }

    package { "$module": ensure => installed }
}
