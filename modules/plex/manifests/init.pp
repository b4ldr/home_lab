# @summary install plex
class plex {
  ensure_resource('file', '/etc/apt/keyrings', {'ensure' => 'present', 'mode' =>'0755'})
  file { '/etc/apt/keyrings/flex.key':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/plex/apt.key',
  }
  apt::source { 'plex':
    location => 'https://downloads.plex.tv/repo/deb',
    release  => 'public',
    keyring  => '/etc/apt/keyrings/flex.key',
    require  => File['/etc/apt/keyrings/flex.key'],
  }
}
