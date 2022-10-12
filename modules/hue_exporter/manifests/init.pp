# @sumary instal and manage hue-exporter
# @param api_key the bridge api key
# @param hue_bridge the hue bridge
class hue_exporter (
  String       $api_key,
  Stdlib::Host $hue_bridge = 'localhost',
) {
  # build manually from https://github.com/aexel90/hue_exporter
  file { '/usr/local/bin/hue-exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
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
