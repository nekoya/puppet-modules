#
# crontab module
#

class crontab {
    define user_cron($server = "") {
        if !$env { $env = "prod" }
        file { "/var/spool/cron/$name":
            mode    => 600,
            owner   => "$name",
            group   => "root",
            source  => [
                "puppet:///files/crontab/$fqdn/$name",
                "puppet:///files/crontab/$env/$server/$name",
                "puppet:///files/crontab/$server/$name",
            ],
        }
    }
}
