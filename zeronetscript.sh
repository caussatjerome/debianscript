apt-get -y install msgpack-python python-gevent
cd /etc
wget https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz
tar xvpfz master.tar.gz
rm master.tar.gz

#set as service method 1:
rm /etc/init.d/zeronet
echo '#!/bin/sh'>/etc/init.d/zeronet
echo '### BEGIN INIT INFO'>>/etc/init.d/zeronet
echo '# Provides:          ZeroNet'>>/etc/init.d/zeronet
echo '# Required-Start:    '>>/etc/init.d/zeronet
echo '# Required-Stop:     '>>/etc/init.d/zeronet
echo '# Default-Start:     2 3 4 5'>>/etc/init.d/zeronet
echo '# Default-Stop:      0 1 6'>>/etc/init.d/zeronet
echo '# Short-Description: ZeroNet'>>/etc/init.d/zeronet
echo '# Description:       ZeroNet'>>/etc/init.d/zeronet
echo '### END INIT INFO'>>/etc/init.d/zeronet
echo '# Actions'>>/etc/init.d/zeronet
echo 'case "$1" in'>>/etc/init.d/zeronet
echo '    start)'>>/etc/init.d/zeronet
echo '        rm -f /etc/ZeroNet-master/data/lock.pid'>>/etc/init.d/zeronet
echo '        python2 /etc/ZeroNet-master/zeronet.py --ui_ip 0.0.0.0'>>/etc/init.d/zeronet
echo '        ;;'>>/etc/init.d/zeronet
echo '    stop)'>>/etc/init.d/zeronet
echo '        # STOP'>>/etc/init.d/zeronet
echo '       ;;'>>/etc/init.d/zeronet
echo '    restart)'>>/etc/init.d/zeronet
echo '        # RESTART'>>/etc/init.d/zeronet
echo '        ;;'>>/etc/init.d/zeronet
echo 'esac'>>/etc/init.d/zeronet
echo 'exit 0'>>/etc/init.d/zeronet

#configure starting
chmod 775 /etc/init.d/zeronet
update-rc.d zeronet defaults
update-rc.d tor enable
#configure firewall
iptables -A INPUT -p tcp -m tcp --dport 43110 -j ACCEPT
iptables-save
#configure tor
sed -i '/ControlPort /s/^#//' /etc/tor/torrc
sed -i '/CookieAuthentication /s/^#//' /etc/tor/torrc
sed -i '/RunAsDaemon /s/^#//' /etc/tor/torrc
#reboot
