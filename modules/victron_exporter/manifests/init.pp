# @sumary instal and manage victron-exporter
# @param version the version to install
# @param mqtt_host the mqtt host to poll
class victron_exporter (
  String       $version   = '0.5.0',
  Stdlib::Host $mqtt_host = 'localhost',
) {
  $download_link = "https://github.com/suprememoocow/victron-exporter/releases/download/v${version}/victron-exporter_${version}_linux_amd64.tar.gz"
  archive { '/tmp/victron-exporter.tar.gz':
    ensure       => present,
    source       => $download_link,
    extract      => true,
    extract_path => '/usr/local/bin',
    creates      => '/usr/local/bin/victron-exporter',
  }
  file { '/usr/local/bin/victron-exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    require => Archive['/tmp/victron-exporter.tar.gz'],
  }
  $command = "/usr/local/bin/victron-exporter -mqtt.host ${mqtt_host}"
  systemd::manage_unit { 'victron-exporter.service':
    enable        => true,
    active        => true,
    unit_entry    => {
      'Description' => 'Exporter for victeron solar',
    },
    service_entry => {
      'Type'      => 'simple',
      'ExecStart' => $command,
      #https://github.com/voxpupuli/puppet-systemd/issues/299
      #'User'      => 'nobody',
      #'Group'     => 'nobody',
    },
    install_entry => {
      'WantedBy' => 'multi-user.target',
    },
  }
}
