#
# nginx module
#

class nginx {
    $module = "nginx"
    define nginx_config() {
        $module = "nginx"
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
            require => Package[$module],
#            notify  => Service[$module],
        }
    }
    nginx_config { "/etc/nginx/nginx.conf": }

    define nginx_template() {
        $module = "nginx"
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template("nginx/$name"),
            require => Package[$module],
#            notify  => Service[$module],
        }
    }

    package { "$module": ensure => installed }

#    service { "$module":
#        ensure  => running,
#        enable  => true,
#        require => Package["$module"],
#    }
}
