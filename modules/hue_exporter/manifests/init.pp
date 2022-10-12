# @sumary instal and manage hue-exporter
# @param api_key the bridge api key
# @param hue_bridge the hue bridge
class hue_exporter (
  String       $api_key,
  Stdlib::Host $hue_bridge = 'localhost',
) {
  # build manually from https://github.com/aexel90/hue_exporter
  file { '/usr/local/bin/hue-exporter':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0555',
  }
  file { '/etc/hue':
    ensure => directory,
  }
  $metrics_file = '/etc/hue/hue_metrics.json'
  file { $metrics_file:
    ensure => file,
    source => 'puppet:///modules/hue_exporter/hue_metrics.json',
  }
  $command = "/usr/local/bin/hue_exporter -hue-url ${hue_bridge} -username ${api_key} -metrics-file ${metrics_file}"
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
