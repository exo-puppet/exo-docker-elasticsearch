define docker_elasticsearch::instance (
  $image              = 'elasticsearch',
  $version,
  $net                = 'bridge',
  $data_dir,
  $node_name          = "${::fqdn}",
  $cluster_name       = 'elasticsearch',
  $publish_host       = "${::fqdn}",
  $bind_address       = '127.0.0.1',
  $cluster_members    = undef,
  $minimum_masters    = undef,
  $repos              = undef,
  $bind_ports         = true,
  $rest_port          = 9200,
  $transport_port     = 9300,
  $user               = 105,
  $group              = 108,
  $heap_size          = '1g',
  $additional_volumes = [],
) {
  file { "/etc/elasticsearch/${node_name}" :
    ensure    => directory,
    require   => [File["/etc/elasticsearch"]],
  }
  -> file { $data_dir :
    ensure  => directory,
    owner   => $user,
    group   => $group,
    recurse => true,
  }
  -> file { "/etc/elasticsearch/${node_name}/elasticsearch.yml" :
    ensure    => 'present',
    content   => template('docker_elasticsearch/elasticsearch.yml.erb'),
    notify    => Service["docker-elasticsearch-${name}"]
  } ->
  docker::run { "elasticsearch-${name}" :
    image     => "${image}:${version}",
    ports     => $bind_ports ? {
      true        => ["${bind_address}:${rest_port}:9200", "${bind_address}:${transport_port}:9300"],
      default     => [],
    },
    volumes   => concat(["${data_dir}:/usr/share/elasticsearch/data", "/etc/elasticsearch/${node_name}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml"], $additional_volumes),
    net       => "${net}",
    subscribe => [Docker::Image["${image}_${version}"], ],
  }

}
