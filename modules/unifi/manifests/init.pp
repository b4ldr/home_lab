# @summary install and manage unifi
class unifi {
  $keyfile = '/etc/apt/keys/unifi-repo.gpg'
  file { $keyfile.dirname():
    ensure => directory,
  }
  file { $keyfile:
    ensure => file,
    source => 'puppet:///modules/unifi/unifi-repo.gpg'
  }
  apt::source { 'unifi':
    location => 'https://www.ui.com/downloads/unifi/debian',
    release  => 'stable',
    repos    => 'ubiquiti',
    keyring  => '/etc/apt/keys/unifi-repo.gpg',
    require  => File[$keyfile],
  }
  package { 'unifi':
    ensure  => 'installed',
    require => Apt::Source['unifi'],
  }
  service { 'unifi':
    ensure  => running,
    require => Package['unifi'],
  }
}
