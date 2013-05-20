
class vlc ($target) inherits vlc::params {

  case $target {
    'win32' : {
      class { 'mingw64': }

      class { 'vlc::builddeps::win32': }

      class { 'vlc::clone': shallow => true }

      class { 'vlc::builder::win32': require => [Class["vlc::clone"], Class["mingw64"], Class["vlc::builddeps::win32"]] }

      class { 'vlc::deploy::win': }
    }
    default: { notice("missing target") }
  }

}