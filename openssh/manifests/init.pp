#
# openssh server and client module
#

class openssh {
    define openssh_config() {
        $module = "openssh"
        file { "$name":
            mode    => 600,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/$module/$fqdn/$name",
                "puppet:///files/$module/$domain/$name",
                "puppet:///files/$module/default/$name",
                "puppet:///modules/$module/$name",
            ],
            require => Package["openssh-server"],
        }
    }
    openssh_config { "/etc/ssh/sshd_config": }

    service { "sshd":
        enable    => true,
        ensure    => running,
        subscribe => File["/etc/ssh/sshd_config"],
        require   => Package["openssh-server"],
    }

    package { ["openssh-server", "openssh-clients"]: ensure => installed }
}
