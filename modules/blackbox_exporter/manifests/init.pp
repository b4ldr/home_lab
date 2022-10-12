class blackbox_exporter (
) {
  ensure_packages('prometheus-blackbox-exporter')
  # https://raw.githubusercontent.com/carlosedp/ddwrt-monitoring/master/blackbox-exporter/blackbox.yml
  service { 'prometheus-blackbox-exporter':
    ensure => running,
  }
}
