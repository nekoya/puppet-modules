#
# logwatch module
#

class logwatch {
    $module = "logwatch"
    define logwatch_config() {
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
    logwatch_config { "/etc/logwatch/conf/logwatch.conf": }

    file { "/etc/cron.daily/0logwatch":
        owner  => "root",
        group  => "root",
        ensure => "/usr/share/logwatch/scripts/logwatch.pl",
    }
}

class logwatch::absent {
    # don't receive e-mail from logwatch
    file { "/etc/cron.daily/0logwatch":
        ensure => absent,
    }
}
