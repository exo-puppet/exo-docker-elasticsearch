define docker_elasticsearch::instance::config (
  $cluster_name
) {
  file { "/etc/elasticsearch/${cluster_name}" :
    ensure    => directory,
    require   => File['/etc/elasticsearch'],
  } ->
  file { "/etc/elasticsearch/${cluster_name}/elasticsearch.yml" :
    ensure    => present,
    content   => template('m_elasticsearch/elasticsearch/elasticsearch.yml.erb'),
  }

  
}