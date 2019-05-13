apt-get -y install msgpack-python python-gevent
cd /etc
wget https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz
tar xvpfz master.tar.gz
rm master.tar.gz

#set as service method 1:
echo [Unit]>/etc/systemd/system/zeronet.service
echo Description=ZeroNet Daemon>/etc/systemd/system/zeronet.service
echo Wants=tor.service
echo After=network-online.target network.target tor.service>/etc/systemd/system/zeronet.service
echo [Service]>/etc/systemd/system/zeronet.service
echo EnvironmentFile=/etc/ZeroNet-master/zeronet.conf>/etc/systemd/system/zeronet.service
echo ExecStart=/etc/ZeroNet-master/zeronet.py --ui_host 0.0.0.0>/etc/systemd/system/zeronet.service
echo Restart=on-failure>/etc/systemd/system/zeronet.service
echo '# Configures the time to wait before service is stopped forcefully.'>/etc/systemd/system/zeronet.service
echo User=yourusernamerunningtheservice>/etc/systemd/system/zeronet.service
echo TimeoutStopSec=30min>/etc/systemd/system/zeronet.service
echo [Install]>/etc/systemd/system/zeronet.service
echo WantedBy=multi-user.target>/etc/systemd/system/zeronet.service
sudo chmod 664 /etc/systemd/system/zeronet.service
sudo systemctl daemon-reload
sudo systemctl enable zeronet.service

#set as service method 2:
echo #!/bin/sh>/etc/init.d/zeronet.sh
echo ### BEGIN INIT INFO>/etc/init.d/zeronet.sh
echo # Provides:          ZeroNet>/etc/init.d/zeronet.sh
echo # Required-Start:    >/etc/init.d/zeronet.sh
echo # Required-Stop:     >/etc/init.d/zeronet.sh
echo # Default-Start:     2 3 4 5>/etc/init.d/zeronet.sh
echo # Default-Stop:      0 1 6>/etc/init.d/zeronet.sh
echo # Short-Description: ZeroNet>/etc/init.d/zeronet.sh
echo # Description:       ZeroNet>/etc/init.d/zeronet.sh
echo ### END INIT INFO>/etc/init.d/zeronet.sh
echo # Actions>/etc/init.d/zeronet.sh
echo case "$1" in>/etc/init.d/zeronet.sh
echo     start)>/etc/init.d/zeronet.sh
echo         rm -f /home/pi/ZeroNet-master/data/lock.pid>/etc/init.d/zeronet.sh
echo         python2 /home/pi/ZeroNet-master/zeronet.py --ui_ip 10.0.0.2>/etc/init.d/zeronet.sh
echo         ;;>/etc/init.d/zeronet.sh
echo     stop)>/etc/init.d/zeronet.sh
echo         # STOP>/etc/init.d/zeronet.sh
echo         ;;>/etc/init.d/zeronet.sh
echo     restart)>/etc/init.d/zeronet.sh
echo         # RESTART>/etc/init.d/zeronet.sh
echo         ;;>/etc/init.d/zeronet.sh
echo esac>/etc/init.d/zeronet.sh
echo exit 0>/etc/init.d/zeronet.sh

sudo chmod 664 /etc/init.d/zeronet.sh
update-rc.d zeronet defaults
