# -*- mode: ruby -*-
# vi: set ft=ruby :

# This script fakes the unpack stage of the installation
$fake_unpack = <<-SCRIPT
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.define :bootstrap do |bootstrap|
    bootstrap.vm.box = "centos/7"
    bootstrap.vm.box_version = "1811.02"

    bootstrap.vm.synced_folder "salt/", "/srv/salt"

    bootstrap.vm.provision "fake-unpack",
      type: "shell",
      inline: $fake_unpack

    bootstrap.vm.provision "bootstrap-node",
      type: "shell",
      path: "bootstrap-node.sh"
  end
end
