terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"
}

provider yandex {
  token     = " "
  cloud_id  = "b1gm8tgm4jndt912jrff"
  folder_id = "b1g642jpnda9c5l6h8fs"
  zone      = "default-ru-central1-a"
}

resource yandex_compute_image ubu-img {
  name          =  "ubuntu-20-04"
  source_image  = "fd8uj3pr8jv6nhmkutag"
}