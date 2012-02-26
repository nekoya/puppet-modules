#
# iptables module
#

class iptables::install {
    package { "iptables": ensure => installed }
}

class iptables::config {
    define iptables_config() {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/iptables/$fqdn/$name",
                "puppet:///files/iptables/$domain/$name",
                "puppet:///files/iptables/default/$name",
                "puppet:///modules/iptables/$name",
            ],
            require => Class["iptables::install"],
            notify  => Class["iptables::service"],
        }
    }
    iptables_config { "/etc/sysconfig/iptables": }
}

class iptables::service {
    service { "iptables":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => Class["iptables::install"],
    }
}

class iptables {
    include iptables::install
    include iptables::config
    include iptables::service
}
