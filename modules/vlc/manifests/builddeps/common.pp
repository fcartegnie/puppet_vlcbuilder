class vlc::builddeps::common {
  include apt

  apt::builddep { "vlc": }
}