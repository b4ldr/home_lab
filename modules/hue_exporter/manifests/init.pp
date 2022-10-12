# @sumary instal and manage hue-exporter
# @param api_key the bridge api key
# @param version the version to install
# @param hue_bridge the hue bridge
class hue_exporter (
  String       $api_key,
  String       $version    = '1.0.0',
  Stdlib::Host $hue_bridge = 'localhost',
) {
  $download_link = "https://github.com/SysdigDan/hue_exporter/releases/download/v${version}/hue_exporter_v${version}_Linux_x86_64.tar.gz"

  archive { '/tmp/hue-exporter.tar.gz':
    ensure       => present,
    source       => $download_link,
    extract      => true,
    extract_path => '/usr/local/bin',
    creates      => '/usr/local/bin/hue_exporter',
  }
  file { '/usr/local/bin/hue-exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    require => Archive['/tmp/hue-exporter.tar.gz'],
  }
  $command = "/usr/local/bin/hue_exporter -hue-url ${hue_bridge} -username ${api_key}"
  systemd::manage_unit { 'hue-exporter.service':
    enable        => true,
    active        => true,
    unit_entry    => {
      'Description' => 'Exporter for Hue',
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
