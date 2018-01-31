$script1 = <<SCRIPT1
   echo "192.168.1.101 server2" >> /etc/hosts   
   yum install git -y
   git clone -b task2 https://github.com/gentosina/task2devops.git 
   cd /home/vagrant/task2devops
   cat test.txt
   chmod 700 /home/vagrant/.ssh/authorized_keys
SCRIPT1

$script2 = <<SCRIPT2
   echo "192.168.1.100 server1" >> /etc/hosts
   yum install expect -y
   ssh-keygen -N '' -f /home/vagrant/.ssh/id_rsa 
   cp /vagrant/expect.exp /tmp/
   expect /tmp/expect.exp
   cd /home/vagrant/.ssh
   chown vagrant:vagrant id_rsa 
   chown vagrant:vagrant id_rsa.pub   
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
 
   config.vm.provision "shell", inline: <<-SHELL   	
      service network restart
SHELL
end
