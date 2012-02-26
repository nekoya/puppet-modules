#
# nagios::nrpe module
#
class nagios::nrpe {
    tag("nrpe")

    if (!$nrpe_custom_commands) {
        $nrpe_custom_commands = ""
    }

    package { "nrpe": ensure => installed }

    package { [
        "nagios-plugins-smtp",
        ]: ensure => installed,
    }

    define nrpe_config_file($file="nagios/etc/nagios/nrpe.cfg") {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
            notify  => Service["nrpe"],
            require => Package["nrpe"],
        }
    }
    nrpe_config_file { "/etc/nagios/nrpe.cfg": }

    service { "nrpe":
        ensure    => running,
        enable    => true,
        require   => Package["nrpe"],
    }
}
