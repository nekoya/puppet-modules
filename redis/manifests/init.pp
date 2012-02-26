#
# redis module
#

class redis {
    define redis_config($template="redis/etc/redis.conf", $redis_port="6379") {
        $module = "redis"
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($template),
            require => Package["redis"],
        }
    }
    redis_config { "/etc/redis.conf": }

    service { "redis":
        enable    => true,
        ensure    => running,
        subscribe => File["/etc/redis.conf"],
        require   => Package["redis"],
    }

    package { ["redis"]: ensure => installed }
}
