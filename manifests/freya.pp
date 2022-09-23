node 'freya.home.arpa' {
    include puppet_apply
    include my_fw::pre
    include firewall
    include my_fw::post
    include prometheus
    include prometheus::node_exporter
    firewall {"101 prometheus":
      proto  => 'tcp',
      dport  => 9090,
      action => 'accept',
    }
    include kibana
}
