Vagrant.configure("2") do |config|
  
  config.vm.box = "bertvv/centos72"

  config.vm.define "servertom1" do |servertom1|
      servertom1.vm.network "private_network", ip: "192.168.1.101"
      servertom1.vm.hostname = "servertom1"  
      servertom1.vm.provision "shell", path: "servers.sh"
      servertom1.vm.provision "shell", inline: $script2   
      
  end
  config.vm.define "servertom2" do |servertom2|
      servertom2.vm.network "private_network", ip: "192.168.1.102"
      servertom2.vm.hostname = "servertom2" 
      servertom2.vm.provision "shell", path: "servers.sh" 
  end
 
  config.vm.define "serverlb" do |serverlb|
      serverlb.vm.network  "private_network", ip: "192.168.1.100"
      serverlb.vm.network "forwarded_port", guest: 8080, host: 18080
      serverlb.vm.network "forwarded_port", guest: 80, host: 18081
      serverlb.vm.network "forwarded_port", guest: 8081, host: 18082
      serverlb.vm.hostname = "serverlb" 
      serverlb.vm.provision "shell", path: "lb.sh"
      serverlb.vm.provision "shell", path: "jenkins.sh"
      serverlb.vm.provision "shell", path: "nexus.sh"
      config.vm.provider "virtualbox" do |vb|
	vb.memory = 2048
       
  end
  end
  
  config.vm.provision "shell", inline: <<-SHELL   	
      service network restart
      
SHELL
end
