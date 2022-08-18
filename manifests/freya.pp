node 'loki.johnbond.org' {
    include puppet_apply
    include my_fw::pre
    include firewall
    include my_fw::post
}
