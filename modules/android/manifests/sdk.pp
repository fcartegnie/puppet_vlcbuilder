class android::sdk(
  $user = $android::params::user,
  $group = $android::params::group,
  $basedir = $android::params::basedir,
  $api = "17", 
) inherits android::params {

  $url = "http://developer.android.com/sdk/index.html"

  exec { "install":
    command   => "url=\$(wget -O /dev/stdout ${url} |\
awk '{ if (match(\$0, \"http://[A-z0-9\\\\.\\\\-/]+\\\\.tgz\")) print substr(\$0, RSTART, RLENGTH) }');\
if test -n \"\$url\"; then wget -O /dev/stdout \$url | tar -zxf /dev/stdin; else exit 1; fi",
    path      => "/usr/bin",
    provider => "shell",
    timeout => "600",
    creates => "${basedir}/android-sdk-linux/tools",
    cwd       => $basedir,
    user      => $user,
    group     => $group,
    logoutput => 'on_failure',
  }
  
  exec { "platform-update":
    command => "echo y | tools/android update sdk -s -u -t android-${api}",
    provider => "shell",
    path      => "/usr/bin",
    cwd       => "${basedir}/android-sdk-linux",
    creates   => "${basedir}/android-sdk-linux/platforms/android-${api}",
    user      => $user,
    group     => $group,
    logoutput => 'on_failure',
    require => Exec["install"],
  }

  exec { "tools-update":
    command => "echo y | tools/android update sdk -s -u -t platform-tool,extra",
    provider => "shell",
    path      => "/usr/bin",
    cwd       => "${basedir}/android-sdk-linux",
    user      => $user,
    group     => $group,
    logoutput => 'on_failure',
    require => Exec["platform-update"],
  }
}
