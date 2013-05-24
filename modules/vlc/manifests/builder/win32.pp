
class vlc::builder::win32 (
  $user = vlc::params::user,
  $group = vlc::params::group,
  $basedir = vlc::params::basedir,
) inherits vlc::params {

  file { "${basedir}/vlc/contrib/win32":
    alias   => "contribdir",
    ensure  => "directory",
    owner   => $user,
    group   => $group,
  }

  exec { "prebuiltbootstrap":
    command => "$basedir/vlc/contrib/bootstrap --host=${triplet}",
    cwd     => "${basedir}/vlc/contrib/win32",
    creates => "${basedir}/vlc/contrib/win32/Makefile",
    user    => $user,
    group   => $group,
    require => File["contribdir"],
    logoutput => 'on_failure',
  }

  exec { "prebuilt":
    command   => "make prebuilt",
    path      => "/usr/bin:/bin",
    cwd       => "${basedir}/vlc/contrib/win32",
    creates   => "${basedir}/vlc/contrib/${triplet}",
    user      => $user,
    group     => $group,
    require   => Exec["prebuiltbootstrap"],
    logoutput => 'on_failure',
  }

  file { [
    "${basedir}/vlc/contrib/${triplet}/bin/moc",
    "${basedir}/vlc/contrib/${triplet}/bin/uic",
    "${basedir}/vlc/contrib/${triplet}/bin/rcc"]:
    ensure  => "absent",
    require => Exec["prebuilt"],
  }

  file { "${basedir}/vlc/win32":
    ensure  => "directory",
    owner   => $user,
    group   => $group,
    require => Exec["bootstrap"]
  }

  exec { "bootstrap":
    command   => "${basedir}/vlc/bootstrap",
    cwd       => "${basedir}/vlc",
    path      => "/usr/bin:/bin",
    creates   => "${basedir}/vlc/configure",
    logoutput => 'on_failure',
    user      => $user,
    group     => $group,
    require   => Exec["prebuilt"]
  }

  exec { "configure":
    command   => "${basedir}/vlc/extras/package/win32/configure.sh --host=${triplet}",
    cwd       => "${basedir}/vlc/win32",
    path      => "/usr/bin:/bin",
    logoutput => 'on_failure',
    user      => $user,
    group     => $group,
    require   => Exec["bootstrap"]
  }

}