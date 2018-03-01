mkdir /opt/nexus
cd /opt/nexus
wget http://sonatype.org/downloads/nexus-2.14.7-01-bundle.tar.gz
tar -xzvf nexus-2.14.7-01-bundle.tar.gz
ln -s nexus-2.14.7-01 nexus
adduser nexus
chown -R nexus:nexus /opt/nexus
cp /opt/nexus/nexus/bin/nexus /etc/init.d/nexus
cd /etc/init.d/
sudo sed -i 's/NEXUS_HOME=".."/NEXUS_HOME="\/opt\/nexus\/nexus"/g' nexus
sudo sed -i 's/#RUN_AS_USER=/RUN_AS_USER="nexus"/g' nexus
mkdir /var/log/nexus
systemctl stop httpd
firewall-cmd --zone=public --permanent --add-port=8081/tcp
firewall-cmd --reload
systemctl start httpd
systemctl daemon-reload
systemctl enable nexus
systemctl start nexus




