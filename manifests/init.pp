define docker_elasticsearch (
  $version  = 'latest',
  $image    = 'elasticsearch', 
) {
  include docker_elasticsearch::directories
  
  docker_elasticsearch::images { "${image}-${version}" :
    image     => "${image}",
    version   => "${version}",
  }
}