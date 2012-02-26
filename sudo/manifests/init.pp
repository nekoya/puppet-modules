#
# sudo module
#

class sudo {
    $module = "sudo"
    define sudo_config() {
        file { "$name":
            mode    => 440,
            owner   => "root",
            group   => "root",
            source  => [
                "puppet:///files/$module/$fqdn/$name",
                "puppet:///files/$module/$domain/$name",
                "puppet:///files/$module/default/$name",
                "puppet:///modules/$module/$name",
            ],
            require => Package[$module],
        }
    }
    sudo_config { "/etc/sudoers": }

    package { "sudo": ensure => installed }
}
