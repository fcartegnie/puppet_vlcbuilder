class android::sdk(
  $user,
  $group,
  $basedir
) {

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

}

