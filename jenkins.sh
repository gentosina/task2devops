yum install java-1.8.0-openjdk-devel -y
   wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
   rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
   yum install jenkins -y
   systemctl start jenkins.service
   systemctl enable jenkins.service
   firewall-cmd --zone=public --add-port=8080/tcp --permanent
   firewall-cmd --reload 
   


