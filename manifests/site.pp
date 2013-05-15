node default {

  if $hardwaremodel == "x86_64" and $operatingsystem == "Debian" {
    class { 'mingw64': }

    class { 'vlc::builddeps::win32': }

    class { 'vlc::clone':
      shallow => true
    }

    class { 'vlc::builder::win32':
      require => [Class["vlc::clone"], Class["mingw64"], Class["vlc::builddeps::win32"]]
    }

    class { 'vlc::deploy::win': }

  } else {
    fail("Unsupported operating system or arch")
  }
}