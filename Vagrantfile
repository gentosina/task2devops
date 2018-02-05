$script1 = <<SCRIPT1
   echo -e "192.168.1.101 servertom1\n192.168.1.102 servertom2" >> /etc/hosts
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
SCRIPT1

$script2 = <<SCRIPT2
   yum install java-1.8.0-openjdk -y
   yum install tomcat tomcat-webapps tomcat-admin-webapps -y
   systemctl enable tomcat
   systemctl start tomcat 
   mkdir /usr/share/tomcat/webapps/task3 
   cd /usr/share/tomcat/webapps/task3
   echo "tomcat1234" >> index.html
SCRIPT2

$script3 = <<SCRIPT3
   yum install java-1.8.0-openjdk -y
   yum install tomcat tomcat-webapps tomcat-admin-webapps -y
   systemctl enable tomcat
   systemctl start tomcat 
   mkdir /usr/share/tomcat/webapps/task3 
   cd /usr/share/tomcat/webapps/task3
   echo "tomcat5678" >> index.html
SCRIPT3

Vagrant.configure("2") do |config|
  
  config.vm.box = "bertvv/centos72"

  config.vm.define "servertom1" do |servertom1|
      servertom1.vm.network "private_network", ip: "192.168.1.101"
      servertom1.vm.hostname = "servertom1"  
      servertom1.vm.provision "shell", inline: $script2   
  end
  config.vm.define "servertom2" do |servertom2|
      servertom2.vm.network "private_network", ip: "192.168.1.102"
      servertom2.vm.hostname = "servertom2"  
      servertom2.vm.provision "shell", inline: $script3
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
