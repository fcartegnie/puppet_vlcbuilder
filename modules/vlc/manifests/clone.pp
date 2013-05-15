
class vlc::clone(
  $shallow = false,
  $repo = "git://git.videolan.org/vlc.git"
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
    logoutput => true
  }

}
