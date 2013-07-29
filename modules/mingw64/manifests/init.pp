
class mingw64 {
  include apt
  $mingw = ["gcc-mingw-w64-i686", "g++-mingw-w64-i686"]

  package { $mingw:
    ensure  => "latest",
    require => Apt::Force["mingw-w64-tools"],
  }

  apt::force { "mingw-w64-tools":
    release => "experimental",
    require => Apt::Source["debian_experimental"],
  }

  apt::source { "debian_experimental":
    location          => "http://debian.proxad.net/debian",
    release           => "experimental",
    repos             => "main",
    required_packages => "debian-archive-keyring",
    key               => "46925553",
    key_server        => "subkeys.pgp.net",
    pin               => "1000",
    include_src       => false,
  }

}
