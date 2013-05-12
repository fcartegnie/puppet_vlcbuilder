class vlc::deploy::win{
  package{[ "zip", "p7zip", "nsis" ]:
    ensure => "present"
  }
}