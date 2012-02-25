#
# hosts module
#

class hosts {
    define hosts_file($file="hosts/etc/hosts") {
        file { "$name":
            mode    => 644,
            owner   => "root",
            group   => "root",
            content => template($file),
        }
    }
    hosts_file { "/etc/hosts": }
}
