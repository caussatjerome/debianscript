apt-get -y install msgpack-python python-gevent
cd /etc
wget https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz
tar xvpfz master.tar.gz
rm master.tar.gz

#set as service method 2:
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
echo '        python2 /etc/ZeroNet-master/zeronet.py --ui_ip 10.0.0.2'>>/etc/init.d/zeronet
echo '        ;;'>>/etc/init.d/zeronet
echo '    stop)'>>/etc/init.d/zeronet
echo '        # STOP'>>/etc/init.d/zeronet
echo '       ;;'>>/etc/init.d/zeronet
echo '    restart)'>>/etc/init.d/zeronet
echo '        # RESTART'>>/etc/init.d/zeronet
echo '        ;;'>>/etc/init.d/zeronet
echo 'esac'>>/etc/init.d/zeronet
echo 'exit 0'>>/etc/init.d/zeronet

chmod 775 /etc/init.d/zeronet
update-rc.d zeronet defaults

#set as service method 1:
echo '### BEGIN INIT INFO'>/etc/systemd/system/zeronet.service
echo '# Provides:          zeronet'>>/etc/systemd/system/zeronet.service
echo '# Default-Start:     2 3 4 5'>>/etc/systemd/system/zeronet.service
echo '# Default-Stop:      0 1 6'>>/etc/systemd/system/zeronet.service
echo '# Short-Description: Start daemon at boot time'>>/etc/systemd/system/zeronet.service
echo '# Description:       Enable service provided by daemon.'>>/etc/systemd/system/zeronet.service
echo '### END INIT INFO'>>/etc/systemd/system/zeronet.service
echo [Unit]>>/etc/systemd/system/zeronet.service
echo Description=ZeroNet Daemon>>/etc/systemd/system/zeronet.service
echo Wants=tor.service>>/etc/systemd/system/zeronet.service
echo After=network-online.target network.target tor.service>>/etc/systemd/system/zeronet.service
echo [Service]>>/etc/systemd/system/zeronet.service
echo EnvironmentFile=/etc/ZeroNet-master/zeronet.conf>>/etc/systemd/system/zeronet.service
echo ExecStart=/etc/ZeroNet-master/zeronet.py --ui_host 0.0.0.0>>/etc/systemd/system/zeronet.service
echo Restart=on-failure>>/etc/systemd/system/zeronet.service
echo '# Configures the time to wait before service is stopped forcefully.'>>/etc/systemd/system/zeronet.service
echo User=yourusernamerunningtheservice>>/etc/systemd/system/zeronet.service
echo TimeoutStopSec=30min>>/etc/systemd/system/zeronet.service
echo [Install]>>/etc/systemd/system/zeronet.service
echo WantedBy=multi-user.target>>/etc/systemd/system/zeronet.service

chmod 775 /etc/systemd/system/zeronet.service
systemctl daemon-reload
systemctl enable zeronet.service
