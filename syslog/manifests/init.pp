#
# syslog module
#

class syslog {
    $module = "syslog"
    define syslog_config() {
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
            notify  => Service[$module],
        }
    }
    syslog_config { "/etc/syslog.conf": }

    service { "syslog":
        enable    => true,
        ensure    => running,
    }
}
