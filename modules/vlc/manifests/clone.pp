
class vlc::clone inherits vlc::params {

  exec { "repoclone":
    command   => "git clone --depth 1 git://git.videolan.org/vlc.git vlc",
    path      => "/usr/bin",
    cwd       => $basedir,
    creates   => "${basedir}/vlc",
    user      => $user,
    group     => $group,
#    require   => [Class["vlcdeps"], Class["mingw"]],
    logoutput => true
  }

}
