node default {

  if $hardwaremodel == "x86_64" and $operatingsystem == "Debian" {
    class { 'mingw64': }

    class { 'vlc::builddeps': }

    class { 'vlc::clone':
      require => Class['vlc::builddeps'], # for git
    }

    class { 'vlc::builder::win32':
      require => [Class["vlc::clone"], Class["mingw64"], Class["vlc::builddeps"]]
    }

  } else {
    fail("Unsupported operating system or arch")
  }
}