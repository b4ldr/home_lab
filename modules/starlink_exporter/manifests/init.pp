# @sumary instal and manage starlink-exporter
# @param version the version to install
class starlink_exporter (
  String       $version   = '1.0.0',
) {
  $download_link = "https://github.com/SysdigDan/starlink_exporter/releases/download/v${version}/starlink_exporter_v${version}_Linux_x86_64.tar.gz"

  archive { '/tmp/starlink-exporter.tar.gz':
    ensure       => present,
    source       => $download_link,
    extract      => true,
    extract_path => '/usr/local/bin',
    creates      => '/usr/local/bin/starlink_exporter',
  }
  file { '/usr/local/bin/starlink-exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    require => Archive['/tmp/starlink-exporter.tar.gz'],
  }
  $command = '/usr/local/bin/starlink_exporter'
  systemd::manage_unit { 'starlink-exporter.service':
    enable        => true,
    active        => true,
    unit_entry    => {
      'Description' => 'Exporter for Starlink',
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
