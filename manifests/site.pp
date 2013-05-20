node default {

  if $hardwaremodel == "x86_64" and $operatingsystem == "Debian" {

    class { 'vlc':
      target => 'win32'
    }

  } else {
    fail("Unsupported operating system or arch")
  }
}