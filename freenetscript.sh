wget 'https://github.com/freenet/fred/releases/download/build01484/new_installer_offline_1484.jar' -O new_installer_offline.jar
apt-get -y install default-jre default-jdk
java -jar new_installer_offline.jar -console
adduser freenet
mkdir /usr/local/freenet
mv /Freenet/* /usr/local/freenet/
ln -s /usr/local/freenet/run.sh /etc/init.d/freenet-new
update-rc.d freenet-new defaults
sed -i 's/#RUN_AS_USER=/RUN_AS_USER=freenet/g' /usr/local/freenet/run.sh
/etc/init.d/freenet-new start
