
class vlc (
  $target,
  $user = $vlc::params::group,
  $group = $vlc::params::group,
  $basedir = $vlc::params::basedir,
) inherits vlc::params {

  case $target {
    'win32' : {
      class { 'mingw64': }

      class { 'vlc::builddeps::win32': }

      class { 'vlc::clone': 
        user => $user,
        group => $group,
        basedir => $basedir,
        shallow => true
      }

      class { 'vlc::builder::win32':
        user => $user,
        group => $group,
        basedir => $basedir,
        require => [Class["vlc::clone"], Class["mingw64"], Class["vlc::builddeps::win32"]]
      }

      class { 'vlc::deploy::win': }
    }
    default: { notice("missing target") }
  }

}