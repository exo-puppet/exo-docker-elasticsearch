define docker_elasticsearch::instance (
  $image              = 'elasticsearch',
  $version,
  $data_dir,
  $node_name          = "${::fqdn}",
  $cluster_name       = 'elasticsearch',
  $publish_host       = "${::fqdn}",
  $cluster_members    = undef,
  $minimum_master     = undef,
  $repos              = undef, 
  $rest_port          = 9200,
  $transport_port     = 9300,
  $heap_size          = '1g',
) {
  file { "/etc/elasticsearch/${node_name}" :
    ensure    => directory,
    require   => [File["/etc/elasticsearch"]],
  } ->
  file { "/etc/elasticsearch/${node_name}/elasticsearch.yml" :
    ensure    => 'present',
    content   => template('docker_elasticsearch/elasticsearch.yml.erb'),
    notify    => Service["docker-elasticsearch-${name}"]
  } ->
  docker::run { "elasticsearch-${name}" :
    image     => "${image}:${version}",
    ports     => ["127.0.0.1:${rest_port}:9200", "127.0.0.1:${transport_port}:9300"],
    volumes   => ["${data_dir}:/usr/share/elasticsearch/data", "/etc/elasticsearch/${node_name}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml"],
  }
  
}