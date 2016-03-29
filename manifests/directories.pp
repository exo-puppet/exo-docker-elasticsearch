class docker_elasticsearch::directories {
  ensure_resource('file', '/etc/elasticsearch', {
    ensure    => directory,
  })
  ensure_resource('file', '/srv/elasticsearch', {
    ensure    => directory,
  })
}