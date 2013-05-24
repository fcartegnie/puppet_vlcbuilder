
class vlc::clone(
  $shallow = false,
  $repo = "git://git.videolan.org/vlc.git",
  $user = $vlc::params::user,
  $group = $vlc::params::group,
  $basedir = $vlc::params::basedir, 
) inherits vlc::params {

  package { "git":
    ensure => "present",
  }

  if $shallow == true { $depth = "" } else { $depth = "--depth 1 " }

  exec { "repoclone":
    command   => "git clone ${depth}${repo} vlc",
    path      => "/usr/bin",
    cwd       => $basedir,
    creates   => "${basedir}/vlc",
    user      => $user,
    group     => $group,
    logoutput => 'on_failure',
  }

}
