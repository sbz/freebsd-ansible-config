# -*- mode: ruby -*-
# vi: set ft=ruby

VAGRANT_FILE_API_VERSION = API_VERSION = "2"

vm = {"name" => "freebsd", "ip" => "192.168.43.251"}

Vagrant.configure(API_VERSION) do |config|
    name = vm["name"]
    ip = vm["ip"]

    config.vm.boot_timeout = 5
    config.vm.define "#{name}" do |node|
        # https://app.vagrantup.com/freebsd
        node.vm.box = "freebsd/FreeBSD-12.2-STABLE"
        node.vm.box_version = "2021.03.11"
        node.vm.hostname = "#{name}"
        node.ssh.hostname = "vagrant"
        node.ssh.password = "vagrant"
        node.vm.network :public_network, bridge: "eth0", ip: "#{ip}", :netmask => "255.255.255.0"
        node.vm.provider "virtualbox" do |v|
            v.memory = "4096"
            v.customize ["modifyvm", :id, "--cpus", 2]
        end
    end
end
