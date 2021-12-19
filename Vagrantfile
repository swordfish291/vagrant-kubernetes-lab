# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
NUM_WORKER_NODE = 2

IP_NW = "192.168.56."
NODE_IP_START = 20

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "base"
  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Provision Master Node
    config.vm.define "k8s-master" do |master|
      master.vm.provider "virtualbox" do |vb|
          vb.name = "k8s-master"
          vb.memory = 2048
          vb.cpus = 2
      end
    master.vm.hostname = "k8s-master"
    master.vm.network :private_network, ip: "192.168.56.10"
    master.vm.network "forwarded_port", guest: 22, host: "#{2741}"
    #install PoweShell
    #master.vm.provision "install-powershell", type: "shell", path: "scripts/install-pwsh.sh"
    #setup network
    master.vm.provision "setup-network", type: "shell", path: "scripts/setup-network.sh"
    master.vm.provision "master-prep", type: "shell", :path => "scripts/master-prep.sh"
    end
  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "k8s-worker-#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "k8s-worker-#{i}"
            vb.memory = 1024
            vb.cpus = 4
        end
        node.vm.hostname = "k8s-worker-#{i}"
        node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
	    	node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

        #install PoweShell
        #node.vm.provision "install-powershell", type: "shell", path: "scripts/install-pwsh.sh"
        #setup network
        node.vm.provision "setup-network", type: "shell", path: "scripts/setup-network.sh"
        node.vm.provision "worker-prep", type: "shell", :path => "scripts/worker-prep.sh"

    end
  end
end
