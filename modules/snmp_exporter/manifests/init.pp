class snmp_exporter (
) {
  ensure_packages('prometheus-snmp-exporter')
  # https://raw.githubusercontent.com/carlosedp/ddwrt-monitoring/master/snmp-exporter/snmp.yml
  service { 'prometheus-snmp-exporter':
    ensure => running,
  }
}
