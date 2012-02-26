#
# nagios module
#
class nagios {
    package { [
        "nagios",
        "nagios-plugins",
        "nagios-plugins-disk",
        "nagios-plugins-load",
        "nagios-plugins-ping",
        "nagios-plugins-procs",
        "nagios-plugins-users",
        "nagios-plugins-tcp",
        "nagios-plugins-ntp",
#        "nagios-plugins-smtp",
        "nagios-plugins-snmp",
        "nagios-plugins-mysql",
        "nagios-plugins-http",
        "nagios-plugins-ssh",
        "nagios-plugins-nrpe",
        "nagios-plugins-nagios",
        "nagios-plugins-perl",
        "perl-Net-SNMP",
        ]: ensure => installed,
    }

    file { "/usr/share/nagios/html/favicon.ico":
        mode   => 644,
        owner  => "root",
        group  => "root",
        source => "puppet:///modules/nagios/usr/share/nagios/html/favicon.ico",
    }

    nagios_plugin { [
        "check_snmp_boostedge.pl",
        "check_snmp_cpfw.pl",
        "check_snmp_css.pl",
        "check_snmp_css_main.pl",
        "check_snmp_env.pl",
        "check_snmp_int.pl",
        "check_snmp_linkproof_nhr.pl",
        "check_snmp_load.pl",
        "check_snmp_mem.pl",
        "check_snmp_nsbox.pl",
        "check_snmp_process.pl",
        "check_snmp_storage.pl",
        "check_snmp_vrrp.pl",
        "check_snmp_win.pl",
    ]: }

    define nagios_plugin() {
        file { "/usr/lib64/nagios/plugins/${name}":
            source  => "puppet:///modules/nagios/usr/lib64/nagios/plugins/${name}",
            mode    => 755,
            owner   => "root",
            group   => "root",
        }
    }
}
