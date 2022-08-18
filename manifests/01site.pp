resources { 'firewall':
  purge => true,
}
Firewall {
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre'],
}
