# -*- mode: ruby -*-
# vi: set ft=ruby

VAGRANT_FILE_API_VERSION = API_VERSION = "2"

vm = {"name" => "freebsd", "ip" => "192.168.1.251"}

Vagrant.config(API_VERSION) do |config|
    name = vm["name"]
    ip = vm["ip"]

    config.vm.define "#{name}" do |node|
        # https://app.vagrantup.com/freebsd
        node.vm.box = "freebsd/FreeBSD-12.2-STABLE"
        node.vm.hostname = "#{name}"
        node.ssh.hostname = "vagrant"
        node.ssh.password = "vagrant"
        node.vm.network :public_network, bridge: "eth0", ip: "#{ip}", :netmask => "255.255.255.0"
        node.vm.provider "virtualbox" do |v|
            v.memory = "8192"
            v.customize ["modifyvm", :id, "--cpus", 8]
        end
    end
end
