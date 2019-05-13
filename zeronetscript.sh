apt-get -y install msgpack-python python-gevent
cd /etc
wget https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz
tar xvpfz master.tar.gz
rm master.tar.gz

#set as service method 1:
echo [Unit]>/etc/systemd/system/zeronet.service
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
chmod 770 /etc/systemd/system/zeronet.service
systemctl daemon-reload
systemctl enable zeronet.service
