mkdir keys
cd keys
wget https://ftp-master.debian.org/keys/ziyi_key_2002.asc
wget https://ftp-master.debian.org/keys/ziyi_key_2003.asc
wget https://ftp-master.debian.org/keys/ziyi_key_2003v2.asc
wget https://ftp-master.debian.org/keys/ziyi_key_2004.asc
wget https://ftp-master.debian.org/keys/ziyi_key_2005.asc
wget https://ftp-master.debian.org/keys/ziyi_key_2006.asc
wget https://ftp-master.debian.org/keys/archive-key-4.0.asc
wget https://ftp-master.debian.org/keys/archive-key-5.0.asc
wget https://ftp-master.debian.org/keys/archive-key-6.0.asc
wget https://ftp-master.debian.org/keys/archive-key-7.0.asc
wget https://ftp-master.debian.org/keys/archive-key-8.asc
wget https://ftp-master.debian.org/keys/archive-key-8-security.asc
wget https://ftp-master.debian.org/keys/archive-key-9.asc
wget https://ftp-master.debian.org/keys/archive-key-9-security.asc
wget https://ftp-master.debian.org/keys/archive-key-10.asc
wget https://ftp-master.debian.org/keys/archive-key-10-security.asc
wget http://repos.systemmonitor.eu.com/rmmagent/Debian_6.0/Release.keys
wget http://repos.systemmonitor.eu.com/rmmagent/Debian_7.0/Release.keys
wget http://repos.systemmonitor.eu.com/rmmagent/Debian_8.0/Release.keys
apt-key add *.asc
apt-key add *.key
apt-key add *.key.1
apt-key add *.key.2
rm *.*
cd ..
rmdir keys

echo #picardie et security>/etc/apt/sources.list.d/old_deb.list
echo deb http://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>/etc/apt/sources.list.d/old_deb.list
echo deb-src http://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>/etc/apt/sources.list.d/old_deb.list
echo deb http://security.debian.org/ stretch/updates main contrib>/etc/apt/sources.list.d/old_deb.list
echo deb-src http://security.debian.org/ stretch/updates main contrib>/etc/apt/sources.list.d/old_deb.list
echo #comptability sources :>/etc/apt/sources.list.d/old_deb.list
echo deb http://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>/etc/apt/sources.list.d/old_deb.list
echo deb http://ftp.u-picardie.fr/mirror/debian/ oldstable main contrib non-free>/etc/apt/sources.list.d/old_deb.list

apt-get update
apt-get -y install apt-transport-https apt-transport-tor apt-p2p aptitude
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo sed -i 's%http://%http://127.0.0.1:9977/%g' /etc/apt/sources.list
sudo rm -rf /var/cache/apt-p2p/cache/*

apt-get -y install smartmontools chkconfig build-essential fakeroot devscripts git default-jre
echo deb tor://sdscoq7snqtznauu.onion/torproject.org debian main>/etc/apt/sources.list.d/tor.list
apt-get update
apt-get -y install tor
