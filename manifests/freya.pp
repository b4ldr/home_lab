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
    include grafana
    firewall {"102 grafana":
      proto  => 'tcp',
      dport  => 3000,
      action => 'accept',
    }
    include victron_exporter
    # TODO: create alarms for victron_alarm
    include starlink_exporter
    # on storage https://github.com/ncabatoff/zfs-exporter
    # running in tmux
    # prometheus-snmp-exporter
    # https://github.com/aexel90/hue_exporter
}
