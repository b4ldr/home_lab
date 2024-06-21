# @sumary instal and manage ecowitt-exporter
class ecowitt_exporter {
  $cmd = '/usr/local/sbin/ecowitt-exporter'

  file { $cmd:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    content => 'puppet:///modules/ecowitt_exporter/ecowitt_exporter.py',
  }

  systemd::manage_unit { 'ecowitt-exporter.service':
    enable        => true,
    active        => true,
    unit_entry    => {
      'Description' => 'Exporter for ecowitt',
    },
    service_entry => {
      'Type'      => 'simple',
      'ExecStart' => $cmd,
    },
    install_entry => {
      'WantedBy' => 'multi-user.target',
    },
  }
}
