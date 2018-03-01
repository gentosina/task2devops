   echo -e "192.168.1.101 servertom1\n192.168.1.102 servertom2" >> /etc/hosts
   yum install java-1.8.0-openjdk -y
   yum install httpd -y
   systemctl enable httpd
   cp /vagrant/mod_jk.so /etc/httpd/modules/
   cp /vagrant/workers.properties /etc/httpd/conf/
   cp /vagrant/myconf.conf /etc/httpd/conf/
   cd /etc/httpd/conf/
   cat myconf.conf >> httpd.conf
   firewall-cmd --zone=public --add-port=80/tcp --permanent
   systemctl start httpd 
   yum install unzip
   wget https://services.gradle.org/distributions/gradle-3.4.1-bin.zip
   mkdir /opt/gradle
   unzip -d /opt/gradle gradle-3.4.1-bin.zip
   export PATH=$PATH:/opt/gradle/gradle-3.4.1/bin
   sudo yum install git
