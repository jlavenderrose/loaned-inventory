# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.host_name = "inv-test.vm.ht-la.org"
  config.vm.forward_port 80, 8080
  

  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. After that it just runs puppet
  config.vm.provision :shell, :path => "shell/bootstrap.sh"
  
  #give VM 1GB of RAM (hopefully make rails happier)
	config.vm.customize ["modifyvm", :id, "--memory", 1024]
	config.vm.customize ["modifyvm", :id, "--cpus", 2]
end
