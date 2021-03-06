class vlc::builddeps::win32 inherits vlc::builddeps::common {

  exec { "addi386arch":
    command => "dpkg --add-architecture i386",
    path    => "/usr/bin:/bin",
    onlyif  => "test `dpkg --print-foreign-architectures|grep -L i386 /dev/stdin`",
  }

  exec { "apt-update":
    command => "apt-get update",
    path    => "/usr/bin:/bin",
    require => Exec["addi386arch"],
  }

  package { ["lua5.2:i386", "subversion"]:
    ensure  => "latest",
    require => [Exec["addi386arch"], Exec["apt-update"]],
  }
}
