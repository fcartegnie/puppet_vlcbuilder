node default {

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