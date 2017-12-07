# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

#Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#  config.vm.box = "ubuntu/xenial64"
#  config.vm.hostname = "suffire"
#  config.vm.network :forwarded_port, guest: 80, host: 8080
#  config.vm.network :forwarded_port, guest: 443, host: 8443
#  config.vm.provision :shell, path: "bootstrap.sh"
#end

Vagrant.configure(2) do |config|

	config.vm.define "coupa" do |machine|
    	machine.vm.box = "ubuntu/xenial64"

  		config.vm.network :forwarded_port, guest: 443, host: 8443  

    	machine.vm.provision "ansible" do |ansible|
      	ansible.verbose = "v"
     		ansible.playbook = "coupa.yml"
        ansible.raw_arguments = ['--check']
      		ansible.extra_vars = {
        		ansible_python_interpreter: "/usr/bin/python3.5",
      		}
    	end
  	end
end