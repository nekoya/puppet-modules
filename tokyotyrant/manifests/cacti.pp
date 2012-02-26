#
# tokyo tyrant cacti monitoring module
#

class tokyotyrant::cacti {
    define tokyotyrant_cacti_script() {
        file { "/usr/local/sbin/$name":
            mode    => 755,
            owner   => "root",
            group   => "root",
            source  => "puppet:///modules/tokyotyrant/usr/local/sbin/$name",
        }
    }
    tokyotyrant_cacti_script { [
    "tt_1978_info_pcpu.sh",
    "tt_1978_info_pcpu_get.sh",
    "tt_1978_info_pcpu_store.sh",
    "tt_1978_info_socket.sh",
    "tt_1978_info_socket_get.sh",
    "tt_1978_info_socket_store.sh",
    "tt_1978_info_threads.sh",
    "tt_1978_info_threads_get.sh",
    "tt_1978_info_threads_store.sh",
    ]: }

    define tokyotyrant_cacti_cron_file() {
        file { "/etc/cron.d/$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            source  => "puppet:///modules/tokyotyrant/etc/cron.d/$name",
        }
    }
    tokyotyrant_cacti_cron_file { [
    "tt_1978_info_pcpu",
    "tt_1978_info_socket",
    "tt_1978_info_threads",
    ]: }

    file { "/var/log/tt_info/":
        ensure => directory,
        mode    => 755,
        owner   => "root",
        group   => "root",
    }
}
