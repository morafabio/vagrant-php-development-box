==Base Box generation

This Vagrant Box was generated using veewee(https://github.com/jedi4ever/veewee), a powerful tool to easily build clean boxes with the essential tools installed out-of-the box like VirtualBox Guest Additions, ruby, chef, puppet, system updates, no passwords, more useful definitions and stuff.

The provided definition was built with

	veewee vbox define 'ubuntu-12.04.2-server-amd64-dist' 'ubuntu-12.04.2-server-amd64'

Feel free to edit 'definitions/ubuntu-12.04.2-server-amd64-dist/definition.rb' to set RAM consumption and disk size.
Running the build action veewee deploys your configuration on a fresh generated machine

	veewee vbox build 'ubuntu-12.04.2-server-amd64-dist'

Export your VirtualBox image to .box

	veewee vbox export 'ubuntu-12.04.2-server-amd64-dist'

If there, destroy previously imported boxes with the same name

	vagrant box remove ubuntu-12.04.2-server-amd64-dist

Import the box into Vagrant

	vagrant box add 'ubuntu-12.04.2-server-amd64-dist' 'ubuntu-12.04.2-server-amd64-dist.box'

Change the Vagrantfile in order to use the new box

  config.vm.box = "ubuntu-12.04.2-server-amd64-dist"
  config.vm.box_url = ""

