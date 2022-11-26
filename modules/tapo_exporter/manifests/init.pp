# @sumary instal and manage tapo-exporter
# @param email the email address for authenticating
# @param password the password address for authenticating
# @param plugs A list of plugs to query
class tapo_exporter (
  String              $email,
  String              $password,
  Array[Stdlib::Host] $plugs = []
) {
  $config = {
    email    => $email,
    password => $password,
    plugs    => $plugs,
  }
  $cmd = '/usr/local/bin/tapo-exporter'
  $git_root = '/srv/tapo_exporter'
  vcsrepo { $git_root:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/b4ldr/tapo-exporter',
  }
  # build manually from https://github.com/aexel90/tapo_exporter
  file { '/usr/local/bin/tapo-exporter':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    cwd     => $git_root,
    content => "#!/bin/bash\n/usr/bin/python3 -m tapo_exporter.__init__ -c ${config_file}",
    require => Vcsrepo[$git_root],
  }
  file { '/etc/tapo':
    ensure => directory,
  }
  $config_file = '/etc/tapo/config.yaml'
  file { $config_file:
    ensure => file,
    config => $config.to_yaml,
  }
  $command = "${cmd} --config ${config_file}"
  systemd::manage_unit { 'tapo-exporter.service':
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
