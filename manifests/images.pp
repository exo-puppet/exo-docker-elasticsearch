define docker_elasticsearch::images (
  $image,
  $version,
) {
  ensure_resource('docker::image', "${image}", {
    image_tag  => "${version}"
  })
}