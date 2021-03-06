#!/bin/sh
#import signing keys for all distrib debian :
mkdir keys
cd keys
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2002.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2003.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2003v2.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2004.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2005.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/ziyi_key_2006.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-4.0.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-5.0.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-6.0.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-7.0.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-8.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-8-security.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-9.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-9-security.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-10.asc
wget --no-check-certificate https://ftp-master.debian.org/keys/archive-key-10-security.asc
#import systemmonitor sign key:
wget --no-check-certificate http://repos.systemmonitor.eu.com/rmmagent/Debian_6.0/Release.key -O rmm6.asc
wget --no-check-certificate http://repos.systemmonitor.eu.com/rmmagent/Debian_7.0/Release.key -O rmm7.asc
wget --no-check-certificate http://repos.systemmonitor.eu.com/rmmagent/Debian_8.0/Release.key -O rmm8.asc
wget --no-check-certificate http://repos.systemmonitor.eu.com/rmmagent/Debian_9.0/Release.key -O rmm9.asc
#import Freenet Project sign key:
wget --no-check-certificate https://freenetproject.org/assets/keyring.gpg
#add key for Kali Linux repo :
apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys 7D8D0BF6
#add key :1
apt-key add *.gpg
apt-key add *.asc
#TOR SIGNING KEYS :
apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 0x4E2C6E8793298290 0x29846B3C683686CC 0xD1483FA6C3C07136 0x3E39CEABFC69F6F7 0xD752F538C0D38C3A 0xEB5A896A28988BF5 0xC218525819F78451 0x21194EBB165733EA 0xEE8CBC9E886DDD89 0x0445B7AB9ABBEEC6 0x42E86A2A11F48D36 0xDBB802B258ACD84F 0x62AF4031C82E0039
rm *.*
cd ..
rmdir keys
#update sourceslist :
echo '#picardie et security'>/etc/apt/sources.list.d/old_deb.list
echo deb https://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>>/etc/apt/sources.list.d/old_deb.list
echo deb-src https://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>>/etc/apt/sources.list.d/old_deb.list
echo deb https://security.debian.org/ stretch/updates main contrib>>/etc/apt/sources.list.d/old_deb.list
echo deb-src https://security.debian.org/ stretch/updates main contrib>>/etc/apt/sources.list.d/old_deb.list
echo '#comptability sources :'>>/etc/apt/sources.list.d/old_deb.list
echo deb https://ftp.u-picardie.fr/mirror/debian/ stable main contrib non-free>>/etc/apt/sources.list.d/old_deb.list
echo deb https://ftp.u-picardie.fr/mirror/debian/ oldstable main contrib non-free>>/etc/apt/sources.list.d/old_deb.list
#sources kali :
echo deb https://http.kali.org/kali kali-rolling main contrib non-free>/etc/apt/sources.list.d/kali_deb.list
#apt-get install recommanded et suggested packets :
echo 'APT::Install-Recommends "true";'>>/etc/apt/apt.conf
echo 'APT::Install-Suggests "true";'>>/etc/apt/apt.conf

#preinstall tools :
apt-get update
apt-get -y dist-upgrade --fix-broken --fix-missing
apt-get -y install apt-transport-https apt-transport-tor apt-p2p aptitude net-tools sudo mlocate --fix-broken --fix-missing
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo sed -i 's%http://%http://127.0.0.1:9977/%g' /etc/apt/sources.list
sudo rm -rf /var/cache/apt-p2p/cache/*

apt-get -y install smartmontools chkconfig build-essential dkms fakeroot devscripts git default-jre --fix-broken --fix-missing
echo deb tor://sdscoq7snqtznauu.onion/torproject.org debian main>/etc/apt/sources.list.d/tor.list
apt-get update
apt-get -y install tor --fix-broken --fix-missing
exit 0
