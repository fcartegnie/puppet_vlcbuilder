class mingw64 {
  include apt
  $mingw = ["gcc-mingw-w64-i686", "g++-mingw-w64-i686"]

  apt::force { $mingw:
    release => "unstable",
    require => Apt::Force["mingw-w64-tools"],
  }

  apt::force { "mingw-w64-tools":
    release => "unstable",
    require => Apt::Source["debian_unstable"],
  }

  apt::source { "debian_unstable":
    location          => "http://debian.proxad.net/debian",
    release           => "unstable",
    repos             => "main",
    required_packages => "debian-archive-keyring",
    key               => "46925553",
    key_server        => "subkeys.pgp.net",
    pin               => "1",
    include_src       => false,
  }

}
