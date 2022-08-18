class my_fw::post {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'reject',
    before => undef,
  }
  firewall { '999 drop all ipv6':
    proto    => 'all',
    action   => 'reject',
    before   => undef,
    provider => 'ip6tables',
  }
}
