$script1 = <<SCRIPT1
   yum install httpd -y
   yum install tomcat -y
   systemctl enable tomcat
   systemctl start tomcat 
   systemctl enable httpd
   cp /vagrant/mod_jk.so /etc/httpd/modules/
   cp /vagrant/workers.properties /etc/httpd/conf/
   cp /vagrant/myconf.conf /etc/httpd/conf/
   cd /etc/httpd/conf/
   cat myconf.conf >> httpd.conf
   firewall-cmd --zone=public --add-port=80/tcp --permanent
   firewall-cmd --reload
   systemctl start httpd  
   cat /vagrant/hosts >> /etc/hosts
SCRIPT1

$script2 = <<SCRIPT2
   yum install java-1.8.0-openjdk -y
   yum install tomcat tomcat-webapps tomcat-admin-webapps -y
   systemctl enable tomcat
   systemctl start tomcat 
   mkdir /usr/share/tomcat/webapps/task3 
   cd /usr/share/tomcat/webapps/task3
   echo 'tomcat'$1 >> index.html
   echo -e 'worker.servertom'$1'.host=192.168.1.10'$1'\nworker.servertom'$1'.port=8009\nworker.servertom'$1'.type=ajp13' >> /vagrant/workers.properties
   echo '192.168.1.10'$1 'servertom'$1 >> /vagrant/hosts
   sed -i '/^worker.lb.balance_workers=/ s/$/ servertom'$1',/' /vagrant/workers.properties
SCRIPT2

VM = 4

Vagrant.configure("2") do |config|
  
   config.vm.box = "bertvv/centos72"
   (1..VM).each do |i|
      config.vm.define "servertom#{i}" do |subconfig|
      subconfig.vm.hostname = "servertom#{i}"
      subconfig.vm.network :private_network, ip: "192.168.1.#{i + 100}"
      subconfig.vm.provision "shell", inline: $script2, :args => i                
   end 
   end
   config.vm.define "serverlb" do |serverlb|
      serverlb.vm.network  "private_network", ip: "192.168.1.100"
      serverlb.vm.network "forwarded_port", guest: 80, host: 18080
      serverlb.vm.hostname = "serverlb" 
      serverlb.vm.provision "shell", inline: $script1
   end
  
   config.vm.provision "shell", inline: <<-SHELL   	
      service network restart
      systemctl stop firewalld
SHELL
end
