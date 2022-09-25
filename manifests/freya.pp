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
    # https://github.com/suprememoocow/victron-exporter/releases/download/v0.5.0/victron-exporter_0.5.0_linux_amd64.tar.gz
    # ./victron-exporter -mqtt.host 192.168.1.83
    # create alarms for victron_alarm
    # on storage https://github.com/ncabatoff/zfs-exporter
    # running in tmux
    # https://github.com/danopstech/starlink_exporter
    # prometheus-snmp-exporter
    # https://github.com/aexel90/hue_exporter
}
