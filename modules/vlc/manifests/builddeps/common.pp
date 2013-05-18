class vlc::builddeps::common {
  include apt

  Exec { timeout => '600' }

  apt::builddep { "vlc": }
}