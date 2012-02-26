#
# memcached module
#

class memcached {
    $module = "memcached"
    define memcached_config($port=11211, $user='memcached', $maxconn=1024, $cachesize=64, $options='') {
        file { "/etc/sysconfig/memcached":
            content => template("memcached/etc/sysconfig/memcached"),
        }
    }

    package { "$module": ensure => installed }

    service { "$module":
        ensure    => running,
        enable    => true,
        require   => Package["$module"],
    }
}
