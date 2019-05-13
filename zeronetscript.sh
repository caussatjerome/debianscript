apt-get -y install msgpack-python python-gevent
cd /etc
wget https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz
tar xvpfz master.tar.gz
rm master.tar.gz

#set as service :
echo [Unit]>/etc/systemd/system/Zeronet.service
echo Description=ZeroNet Daemon>/etc/systemd/system/Zeronet.service
echo After=network-online.target>/etc/systemd/system/Zeronet.service
echo After=tor.service>/etc/systemd/system/Zeronet.service
echo [Service]>/etc/systemd/system/Zeronet.service
echo Type=simple>/etc/systemd/system/Zeronet.service
echo ExecStart=python /etc/ZeroNet-master/zeronet.py>/etc/systemd/system/Zeronet.service
echo Restart=on-failure>/etc/systemd/system/Zeronet.service
echo # Configures the time to wait before service is stopped forcefully.>/etc/systemd/system/Zeronet.service
echo TimeoutStopSec=300>/etc/systemd/system/Zeronet.service
echo [Install]>/etc/systemd/system/Zeronet.service
echo WantedBy=multi-user.target>/etc/systemd/system/Zeronet.service

systemctl enable Zeronet
systemctl start Zeronet
