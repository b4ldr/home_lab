node 'freya.home.arpa' {
    include puppet_apply
    include my_fw::pre
    include firewall
    include my_fw::post
    include prometheus
    include prometheus::node_exporter
    firewall { '101 prometheus':
      proto  => 'tcp',
      dport  => 9090,
      action => 'accept',
    }
    include grafana
    firewall { '102 grafana':
      proto  => 'tcp',
      dport  => 3000,
      action => 'accept',
    }
    include victron_exporter
    # TODO: create alarms for victron_alarm
    include starlink_exporter
    include hue_exporter
    include snmp_exporter
    include blackbox_exporter
    include tapo_exporter
    # on storage https://github.com/ncabatoff/zfs-exporter
    firewall { '103 plex':
      proto  => 'tcp',
      dport  => 32400,
      action => 'accept',
    }
    include plex
}
