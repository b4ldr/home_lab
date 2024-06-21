node 'freya.home.arpa' {
  include puppet_apply
  include my_fw::pre
  include firewall
  include my_fw::post
  include python
  include prometheus
  include prometheus::node_exporter
  firewall { '101 prometheus':
    proto  => 'tcp',
    dport  => 9090,
    action => 'accept',
    source => '192.168.1.0/24',
  }
  include grafana
  firewall { '102 grafana':
    proto  => 'tcp',
    dport  => 3000,
    action => 'accept',
    source => '192.168.1.0/24',
  }
  include victron_exporter
  # TODO: create alarms for victron_alarm
  include starlink_exporter
  include hue_exporter
  include snmp_exporter
  include blackbox_exporter
  include tapo_exporter
  include ecowitt_exporter
  firewall { '105 ecowitt':
    proto  => 'tcp',
    dport  => 8080,
    action => 'accept',
    source => '192.168.1.0/24',
  }
  # on storage https://github.com/ncabatoff/zfs-exporter
  firewall { '103 plex':
    proto  => 'tcp',
    dport  => 32400,
    action => 'accept',
    source => '192.168.1.0/24',
  }
  include plex

  systemd::manage_dropin { 'limits.conf':
    ensure        => present,
    unit          => 'prometheus.service',
    service_entry => {
      'LimitNOFILE' => 49152,
    },
  }
}
