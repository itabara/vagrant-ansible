# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  # define Dev-box (web in this case) box
  # In Ruby, variable names start with lower-case letters :)
    config.vm.define "devbox" do |devbox|
      devbox.vm.box = "ubuntu/trusty64"
      devbox.vm.network "public_network"
      devbox.vm.network "private_network", ip: "192.168.11.10"
      devbox.vm.provider "virtualbox" do |v|
        v.name = "DevBox"
        v.cpus = 2
        v.memory = 768
      end

      devbox.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
      devbox.vm.provision :file do |file|
        file.source      = 'C:\Users\admin\.vagrant.d\insecure_private_key'
        file.destination = '/home/vagrant/.ssh/id_rsa'
      end
      devbox.vm.provision :shell, path: "dev-box.sh"
      devbox.vm.network "forwarded_port", guest: 80, host: 8080
  end

    # Build the Linux Master Box
    # define ansible control box
    # we'll provision this last so it can add other hosts
    # to known_hosts for ssh authentication
    config.vm.define "devmaster" do |devmaster|
      devmaster.vm.box = "ubuntu/trusty64"
      devmaster.vm.network "public_network"
      devmaster.vm.network "private_network", ip: "192.168.10.10"
      devmaster.vm.provider "virtualbox" do |v|
        v.name = "Dev Master"
        v.cpus = 1
        v.memory = 512
      end

      devmaster.vm.provision "fix-no-tty", type: "shell" do |s|
        s.privileged = false
        s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      # copy private key so hosts can ssh using key authentication (the script below sets permissions to 600)
      devmaster.vm.provision :file do |file|
        file.source      = 'C:\Users\admin\.vagrant.d\insecure_private_key'
        file.destination = '/home/vagrant/.ssh/id_rsa'
      end
      devmaster.vm.provision :shell, path: "dev-master.sh"
    end
    # consider using agent forwarding instead of manually copying the private key as I did above
    # config.ssh.forward_agent = true
end
