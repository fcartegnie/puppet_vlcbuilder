node default {

  # Override this global timeout depending on host speed/bandwidth
  Exec { timeout => '600' }

  if $hardwaremodel == "x86_64" and $operatingsystem == "Debian" {

    class { 'vlc':
      target => 'win32',
      # uncomment/modify overriden variables here if not defaulting to vagrant 
      # user => 'foo',
      # group => 'foo',
      # basedir => '/home/foo',
    }

  } else {
    fail("Unsupported operating system or arch")
  }
}