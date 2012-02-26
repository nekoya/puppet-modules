#
# postfix module
#

class postfix {
    $module = "postfix"

    define postfix_main_cf($file="postfix/etc/postfix/main.cf") {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
            require => Package["$module"],
            notify  => Service["$module"],
        }
    }
    postfix_main_cf { "/etc/postfix/main.cf": }

    package { "$module": ensure => installed }

    service { "$module":
        ensure  => running,
        enable  => true,
        require => Package["$module"],
    }

    define postfix_aliases() {
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
        }
    }
    postfix_aliases { "/etc/aliases": }

    exec {
      "newaliases":
        command     => "newaliases",
        subscribe   => File["/etc/aliases"],
        refreshonly => true,
        notify      => Service["$module"],
    }
}
