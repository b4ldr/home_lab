#
class my_fw::pre (
    Hash $rules,
) {
    Firewall {
        require => undef,
    }
    $rules.each |String $name, Hash $rule| {
        firewall { $name:
            * => $rule
        }
    }
}

