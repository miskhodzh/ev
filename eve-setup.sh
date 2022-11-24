#!/bin/sh
#Modify /etc/ssh/sshd_config with: PermitRootLogin yes
sed -i -e "s/.*PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config
sed -i -e 's/.*DefaultTimeoutStopSec=.*/DefaultTimeoutStopSec=5s/' /etc/systemd/system.conf
systemctl restart ssh
apt-get update
apt-get -y install software-properties-common
wget -O - http://www.eve-ng.net/focal/eczema@ecze.com.gpg.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64]  http://www.eve-ng.net/focal focal main"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install eve-ng
/etc/init.d/mysql restart
DEBIAN_FRONTEND=noninteractive apt-get -y install eve-ng
echo root:eve | chpasswd 
ROOTLV=$(mount | grep ' / ' | awk '{print $1}')
echo $ROOTLV
lvextend -l +100%FREE $ROOTLV
echo Resizing ROOT FS
resize2fs $ROOTLV
reboot
