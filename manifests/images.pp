define docker_elasticsearch::images (
  $image,
  $version,
) {
  ensure_resource('docker::image', "${image}_${version}", {
    image      => "${image}",
    image_tag  => "${version}"
  })
}