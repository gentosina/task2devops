$script1 = <<SCRIPT1
   echo "192.168.1.101 server2" >> /etc/hosts   
   service network restart
   yum install git -y
   git clone -b task2 https://github.com/gentosina/task2devops.git 
   cd /home/vagrant/task2devops
   cat test.txt
SCRIPT1

$script2 = <<SCRIPT2
   echo "192.168.1.100 server1" >> /etc/hosts
   service network restart
SCRIPT2

Vagrant.configure("2") do |config|
  
  config.vm.box = "bertvv/centos72"

 
  config.vm.define "server1" do |server1|
      server1.vm.network  "private_network", ip: "192.168.1.100"
      server1.vm.hostname = "server1" 
      server1.vm.provision "shell", inline: $script1
  end

  config.vm.define "server2" do |server2|
      server2.vm.network "private_network", ip: "192.168.1.101"
      server2.vm.hostname = "server2"  
      server2.vm.provision "shell", inline: $script2
     
  end

  
end
