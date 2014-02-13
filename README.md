VLC Build Environment setup using puppet
===========

Puppet classes for creating a fully configured VLC build environment.

Currently only targets Win32 builds on 64 bits Debian.

Designed to be integrated into a Vagrant image. (see vlc::params)

Usage
===========
    git clone --recursive https://github.com/fcartegnie/puppet_vlcbuilder.git

Add custom params to manifests/site.pp if needed. (defaults to vagrant environment)
See modules/vlc/manifests/params.pp for values to override.

    class { 'vlc': (....) user => 'foobar', group=>'users' }

On the Debian host, install puppet and 

    cd clonedir
    sudo puppet apply manifests/site.pp --modulepath=modules/

Don't forget to set "clonedir" to the real directory :)

