#!/bin/bash

##############################################
# coded by : ganda - guwe.pro pansakom       #
##############################################
#~	DebsTool - Debian Server Tools      ~#
#~	Easy Configuration Debian Server    ~#
#~	Make Fast Your Work~ 	            ~#
#~	INDONESIAN LINUX CODE SECURITY	    ~#
#-----------------guwe.pro------------------~#

m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
n="\033[1;0m"

a_cekKoneqzi(){
echo "Checking internet Connection..."
wget -q --tries=10 --timeout=20 --spider https://google.com
if [[ $? -eq 0 ]]; then
echo -e $h"[+] Yokatta ! You Are Online !"$n
sleep 2
else
echo -e $m"[-] Gomennasai.. You Are Offline :( OR You internet to slow.."
sleep 3
a_main
fi
}

a_confnet(){
	nano /etc/network/interfaces
	clear
	echo "[+] Restarting Networking..."
	/etc/init.d/networking restart
	sleep 2
}
a_confrep(){
	nano /etc/apt/sources.list
	clear
	echo "[+] Updating software..."
	apt-get update
	sleep 2
}
a_hostx(){
	if [[ `hostname` != `hostname -f` ]]; then
		clear
		echo "[+] hostname dan hostname -f tidak sama"
		echo "hostname    :"`hostname`
		echo "hostname -f :"`hostname -f`
		echo -n "[+] Configure hostname :"
		read h
		echo $h > /etc/hostname
		clear
		echo "restarting hostname.sh ..."
		/etc/init.d/hostname.sh start
		sleep 2
		echo -n "What You Wan't to Reboot ? [Y/n] "
		read c
		if [[ $c == "Y" || $c == "" || $c == "y" ]]; then
			reboot
		else
			clear
			a_main
		fi
	else
		echo "[+] Hostname & hostname -f sudah sama"
		sleep 5
	fi
}
a_localex(){
	clear
	echo "[+] Reconfiguring locales..."
	dpkg-reconfigure locales
	sleep 1
	clear
	echo "[+] Generating locales..."
	locale-gen
	sleep 1
}
a_intntp(){
	clear
	echo "[+] Installing ntp server..."
	apt-get install ntp
	sleep 2
	clear
	echo "[+] Configuring /etc/ntp.conf ..."
	sleep 1
	cat /etc/ntp.conf | grep debian
	if [[ "$?" -eq "0" ]]; then
		echo "[+] Found debian default ntp Configurationz ..."
		sleep 1
		echo "[+] Replacing debian to id ..."
		sed -i 's/debian/id/g' /etc/ntp.conf
		echo "[+] Replaced......................................................"
		sleep 1
		clear
		cat /etc/ntp.conf
		exit 0
	else
		echo "Can't Find debian Configurationz ..."
		sleep 1
		echo "Configure manual ..."
		sleep 1
		nano /etc/ntp.conf
	fi
	sleep 1
	echo "[+] Restarting Ntp service ..."
	/etc/init.d/ntp restart
	sleep 2
	clear
	echo "[+] Checking NTP status..."
	ntpq -p
	sleep 4
}
a_webserv(){
	apt-get install apache2
    sleep 2
    clear
    echo "---------------------------------------"
    echo "|          INSTALL PHP VERSION         |"
    echo "---------------------------------------"
    echo "[1] PHP5 | [2] PHP7 | [?] Default PHP5"
    echo -n "php :"
    read p
    if [[ $p == "1" ]]; then
    	echo "[+] Installing PHP5 and PHP5-EXTENSION ..."
    	apt-get install php5 php5-mysql php5-gd php5-json
    	apt-get install php5-mcrypt php5-xmlrpc php5-cli
    	apt-get install php5-intl php5-curl php5-pear php5-imagick
    	sleep 2
    	clear
    elif [[ $p == "2" ]]; then
    	 echo "[+] Installing PHP and PHP-EXTENSION ..."
    	apt-get install php php-mysql php-gd php-json
    	apt-get install php-mcrypt php-xmlrpc php-cli
    	apt-get install php-intl php-curl php-pear php-imagick
    	sleep 2
    	clear
    else
    	 echo "[+] Installing PHP5 and PHP5-EXTENSION ..."
    	apt-get install php5 php5-mysql php5-gd php5-json
    	apt-get install php5-mcrypt php5-xmlrpc php5-cli
    	apt-get install php5-intl php5-curl php5-pear php5-imagick
    	sleep 2
    	clear
    fi
    echo "-----------------------------------"
    echo "|      INSTALL DATABASE SERVER     |"
    echo "-----------------------------------"
    echo "[1] Mysql-server [2] mariadb-server [?] Default mariadb-server !"
    echo -n "DBserver :"
    read dbs
    if [[ $dbs == "1" ]]; then
    	clear
    	echo "[+] Installing Mysql-server ..."
    	apt-get install mysql-server
    elif [[ $dbs == "2" ]]; then
    	clear
    	echo "[+] Installing mariadb-server..."
    	apt-get install mariadb-server
    else
    	clear
    	echo "[+] Installing mariadb-server..."
    	apt-get install mariadb-server
    fi
    mysql_secure_installation
    clear
    sleep 1
    echo "[+] Installing phpmyadmin..."
    apt-get install phpmyadmin
    clear
    sleep 1
    echo "[+] Activating rewrite .htaccess ..."
    a2enmod rewrite
    sleep 2
}
a_sslx(){
	clear
    echo "[+] Generating Certificate..."
    openssl req -new -x509 -days 365 -nodes -out /etc/apache2/apache2.pem -keyout /etc/apache2/apache2.pem
    clear
    sleep 1
    echo "[+] Enable ssl mode..."
    a2enmod ssl
    sleep 2
    clear
    echo "[+] Add Listening Port 443 ... "
    echo \# PORT LISTEN 443 BY ALINKO :v >> /etc/apache2/ports.conf
    echo Listen 443 >> /etc/apache2/ports.conf
    sleep 1
    clear
    echo "[+] View in site available , ...."
    ls /etc/apache2/sites-available/
    echo -n "sites-available config :"
    read sa
    nano /etc/apache2/sites-available/$sa
    sleep 1
    clear
    echo "[+] Restarting webserver..."
    /etc/init.d/apache2 restart
    sleep 1
    clear
}
a_samba(){
	clear
 	echo "[+] Installing Samba server..."
 	apt-get install samba
 	clear
 	sleep 1
 	echo "[+] Configuring samba server..."
 	echo \#SAMBA SERVER CONFIGURATION FILE BY GANDA >> /etc/samba/smb.conf
 	nano /etc/samba/smb.conf
 	echo -n "[+] Samba User :"
 	read u
 	smbpasswd -a $u
 	if [[ "$?" -eq "0" ]]; then
 		echo "[+] Added User $u to samba server ..."
 	else
 		echo -n "[+] samba user :"
 		read x
 		smbpasswd -a $x
 	fi
 	sleep 2
 	clear
 	echo "[+] Restarting samba ..."
 	/etc/init.d/samba restart
 	sleep 2
}
a_fptd(){
	clear
	echo "[+] Installing Proftpd ..."
	apt-get install proftpd
	clear
	sleep 1
	echo "[+] Configuring proftpd ..."
	nano /etc/proftpd/proftpd.conf
	echo -n "Add user : "
	read ux
	adduser $ux
	echo "[+] Restarting proftpd service ..."
	/etc/init.d/proftpd restart
	sleep 2
}
a_dnsx(){
	echo "[+] Installing bind9 ..."
	apt-get install bind9
	sleep 2
	clear
	echo "[+] Configuring bind9 ..."
	sleep 1
	nano /etc/bind/named.conf.local
	sleep 1
	echo -n "[+] Copy db.local to : "
	read db
	cp /etc/bind/db.local /etc/bind/$db
	sleep 1
	echo -n "[+] Copy db.127 to  : "
	read dbx
	cp /etc/bind/db.127 /etc/bind/$dbx
	sleep 1
	clear
	nano /etc/bind/$db
	nano /etc/bind/$dbx
	echo "[+] Restarting service BIND9 ..."
	/etc/init.d/bind9 restart
	sleep 2
	clear
	echo "----------[ Checking Nslookup & Dig ]---------"
	echo -n "[+] domain name : "
	read dn
	echo "[+] NSLOOKUP FOR $dn ..."
	nslookup $dn
	sleep 1
	echo "[+] DIG FOR $dn ..."
	dig $dn
	sleep 1
}
a_mailx(){
	clear
	echo "[+] Installing {postfix,courier-pop,courier-imap} ..."
	apt-get install postfix courier-pop courier-imap
	sleep 2
	clear
	echo "[+] Make directory '/etc/skel/Maildir' ..."
	maildirmake /etc/skel/Maildir
	sleep 1
	clear
	echo "[+] Configuring mail ..."
	nano /etc/postfix/main.cf
	sleep 1
	clear
	echo "[+] Reconfiguring postfix ..."
	dpkg-reconfigure postfix
	sleep 1
	clear
	echo "[+] Restarting {postfix,courier-imap,courier-pop,bind9} ..."
	/etc/init.d/postfix restart
	/etc/init.d/courier-imap restart
	/etc/init.d/courier-pop restart
	/etc/init.d/bind9 restart
	sleep 1
	clear
	echo -n "Add user1 : "
	read us
	adduser $us
	echo -n "Add user2 : "
	read us2
	adduser $us2
	sleep 2
	clear
	echo "----- [ Installing WEBMAIL - squirrelmail ] -----"
	apt-get install squirrelmail
	sleep 1
	clear
	echo "[+] Including squirrelmail to apache2 configration ..."
	echo Include "/etc/squirrelmail/apache.conf" >> /etc/apache2/apache2.conf
	sleep 1
	clear
	echo "[+] Restarting service apache2 ..."
	/etc/init.d/apache2 restart
	sleep 1
	echo "[+] Create Symbolic link to '/var/www/html/mail' ..."
	ln -s /usr/share/squirrelmail /var/www/html/mail
	sleep 2
}
a_radiox(){
	clear
	echo "[+] Installing icecast2 ..."
	apt-get install icecast2
	sleep 2
	clear
	nano /etc/icecast2/icecast.xml
	clear
	echo "[+] Configuring icecast2 ..."
	nano /etc/default/icecast2
	clear
	echo "[+] Restarting service icecast2 ..."
	/etc/init.d/icecast2 restart
}
a_webmin(){
	clear
	a_cekKoneqzi
	echo "[+] Downloading webmin ..."
	wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
	sleep 1
	clear
	echo "[+] Installing Dependencies ..."
	 apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl
	 apt-get install libpam-runtime libio-pty-perl apt-show-versions python
	 sleep 1
	 clear
	echo "[+] Checking For available file webmin_1.831_all.deb ..."
	sleep 2
	cekw=`ls` | grep "webmin_1.831_all.deb"
	if [[ $cekw -eq "0" ]]; then
		clear
		echo "[+] webmin_1.831_all.deb already exists ..."
		echo "[+] Installing Webmin ..."
		dpkg -i webmin_1.831_all.deb
	else
		clear
		echo "[-] File webmin_1.831_all.deb doesn't exists in this server .. "
		echo "[!] Download or Upload manualy to this server ..."

	fi
	sleep 1
}
a_nagios3(){
	clear
	a_cekKoneqzi
	sleep 2
	clear
	echo "[+] Installing nagios3 ..."
	apt-get install nagios3 nagios-nrpe-plugin
	sleep 3
	clear
	echo "[+] Modify user nagiosadmin to group www-data ..."
	usermod -a -G nagios www-data
	sleep 1
	clear
	echo "[+] Change Permission /var/lib/nagios ..."
	chmod -R +x /var/lib/nagios3
	sleep 1
	clear
	echo "[+] Replacing 0 to 1 to /etc/nagios3/nagios.cfg ..."
	sed -i 's/check_external_commands=0/check_external_commands=1/g'  /etc/nagios3/nagios.cfg
	sleep 3
	clear
	echo "[+] Restarting nagios3 service ..."
	/etc/init./nagios3 restart
	sleep 2
}
a_monitorix(){
	a_cekKoneqzi
	echo "[+] Downloading Monitorix ..."
	wget http://www.monitorix.org/monitorix_3.9.0-izzy1_all.deb
	sleep 1
	clear
	echo "[+] Installing Dependencies ..."
	apt-get install rrdtool perl libwww-perl libmailtools-perl libmime-lite-perl librrds-perl
	apt-get install libdbi-perl libxml-simple-perl libhttp-server-simple-perl libconfig-general-perl
	apt-get install libio-socket-ssl-perl
	sleep 2
	clear
	echo "[+] Checking For available file monitorix_3.9.0-izzy1_all.deb ..."
	sleep 2
	cekm=`ls` | grep "monitorix_3.9.0-izzy1_all.deb"
	if [[ $cekm -eq "0" ]]; then
		clear
		echo "[+] monitorix_3.9.0-izzy1_all.deb already exists ..."
		echo "[+] Installing Monitorix ..."
		dpkg -i monitorix_3.9.0-izzy1_all.deb
	else
		clear
		echo "[-] File monitorix_3.9.0-izzy1_all.deb doesn't exists in this server .. "
		echo "[!] Download or Upload manualy to this server ..."

	fi
}
a_asterisk(){
	 clear
	 echo "[+] Installing asterisk ..."
	 apt-get install asterisk
	 sleep 1
	 clear
	 echo \# ASTERISK FILE CONFIGURATION BY ALINKO >> /etc/asterisk/sip.conf
	 echo \# ASTERISK FILE CONFIGURATION BY ALINKO >> /etc/asterisk/extensions.conf
	 nano /etc/asterisk/sip.conf
	 nano /etc/asterisk/extensions.conf
	 sleep 2
	 clear
	 echo "[+] Restarting asterisk ..."
	 /etc/init.d/asterisk restart
	 sleep 2
	 a_main
}
a_cekwebserver(){
	echo "[+] Checking For Apache2 Installed ..."
	sleep 1
	which a2enmod > /dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		echo -e $h"[+] apache2 installed ..."$n
		sleep 1
	else
		echo -e $m"[+] apache2 not installed ..."$n
		sleep 1
		exit 0
	fi
}
a_cms(){
	clear
	a_cekwebserver
	clear
	echo "+------------------------------------------+"
	echo -e "|$m Debian Server Tools - DebsTool - 2k17$n    |"
	echo -e "|$b  Select Your Content Management System$n   |"
	echo "+------------------------------------------+"
	echo -e "[1]$h Wordpress$n      [6]$h Moodle $n"
	echo -e "[2]$h Balitbang$n      [7]$h MyBB $n"
	echo -e "[3]$h Joomla  $n       [8]$h PopojiCMS $n"
	echo -e "[4]$h Drupal  $n       [9]$h Slims Akasia $n"
	echo -e "[5]$h Magentoo$n       [10]$h Your Own CMS $n"
	echo -n "Your CMS >>"
	read cms
	# ACTION
	if [[ $cms == "1" ]]; then
		a_cekwebserver
		a_cekKoneqzi
		sleep 2
		echo "[+] Downloading wordpress ..."
		echo -n "[+] Please wait ..."
		wget https://wordpress.org/latest.tar.gz > /dev/null 2>&1
		sleep 1
		echo "[+] Extracting wordpress ..."
		echo -n "[+] Please wait ..."
		tar -xvf latest.tar.gz > /dev/null 2>&1
		sleep 1
		echo "[+] Moving directory wordpress to /var/www/html ..."
		mv wordpress /var/www/html/wordpress
		sleep  1
		echo "[+] Change Owner to www-data ..."
		chown www-data:www-data -R /var/www/html/wordpress
		sleep 1
		echo "[+] Checking wordpress available ..."
		ls /var/www/html | grep "wordpress" > /dev/null 2>&1
		if [[ "$?" -eq "0" ]]; then
			echo -e $h"[+] Wordpress available in /var/www/html/wordpress !"$n
			echo "[+] Wordpress Ready to install. Go to Your Web browser and open your wordpress now!"
		else
			echo -e $m"[-] Wordpress not available in /var/www/html/wordpress "$n
			echo "[-] Installation failed."
		fi
	elif [[ $cms == "2" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading Balitbang ..."
		echo -n "[+] Please wait ..."
		wget http://rspdklaten.id/data/CMS/CMS%20Balitbang353/cmsbalitbangv353.zip > /dev/null 2>&1
		sleep 1
		# MORE
	elif [[ $cms == "3" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading Joomla ..."
		echo -n "[+] Please wait ..."		
		wget https://github.com/joomla/joomla-cms/releases/download/3.7.0-beta2/Joomla_3.7.0-beta2-Beta-Update_Package.tar.gz > /dev/null 2>&1
		sleep 1
		# more
	elif [[ $cms == "4" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading Drupal ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/drupal/drupal/archive/8.2.6.tar.gz > /dev/null 2>&1
		sleep 1
		# more
	elif [[ $cms == "5" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading Magentoo ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/magento/magento2/archive/2.1.4.tar.gz > /dev/null 2>&1
		sleep 1
		# more
	elif [[ $cms == "6" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading moodle ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/moodle/moodle/archive/v3.0.8.tar.gz > /dev/null 2>&1
		# more
	elif [[ $cms == "7" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading mybb ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/mybb/mybb/archive/mybb_1810.tar.gz > /dev/null 2>&1
		# more
	elif [[ $cms == "8" ]]; then
		a_cekKoneksi
		a_cekKoneksi
		echo "[+] Downloading PopojiCMS ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/PopojiCMS/PopojiCMS/archive/v2.0.1.tar.gz > /dev/null 2>&1
		#more
	elif [[ $cms == "9" ]]; then
		a_cekwebserver
		a_cekKoneksi
		echo "[+] Downloading slims8 akasia ..."
		echo -n "[+] Please wait ..."
		wget https://github.com/slims/slims8_akasia/archive/master.zip > /dev/null 2>&1
		# more

	fi
}
a_updatex(){
	which git > /dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		clear
		a_cekKoneksi
		echo "[+] Checking For Updates ..."
		curl -s https://raw.githubusercontent.com/alintamvanz/debsetool/master/update | grep "YES"
		if [[ "$?" -eq "0" ]]; then
			echo -e $b"[!] UPDATE AVAILABLE ..."
			sleep 1
			echo "[+] Updating Please wait..."
		    git clone https://github.com/alintamvanz/debsetool.git /usr/share/debsetool > /dev/null 2>&1
		    echo -n "[+] Get : https://github.com/alintamvanz/debsetool.git ..."
		    sleep 1
		    echo -n "[+] Get : Change Permission ..."; sleep 1
		    chmod 755 -R /usr/share/debsetool
		    bash /usr/share/debsetool/install
		else
			echo -e $k"[!] UPDATE NOT AVAILABLE .."
			exit 0
		fi
	else
	echo "[+] Your System not already install 'git' .."
	echo -n "[!] What You Want to install git ? [Y/n] "
	read g
	if [[ $g == "Y" || $g == "y" || $g == "" ]]; then
		apt-get install git
	else
		exit 0
	fi
	fi
}
a_repo_depen(){
	clear
	echo "[+] Checking Dependencies ..."
	which a2enmod > /dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		echo -e $h"[+] Apache2...........INSTALLED !"$n
	else
		echo -e $m"[-] Apache2.......NOT INSTALLED !"$n
		sleep 1
		echo "[+] Installing Apache2 ..."
		apt-get install  apache2
		sleep 1
		clear
	fi
	which rsync > /dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		echo -e $h"[+] Rsync.............INSTALLED !"$n
	else
		echo -e $m"[-] Rsync.........NOT INSTALLED !"$n
		sleep 1
		echo "[!] Installing rsync ..."
		apt-get install rsync
		sleep 1
		clear
	fi
	which dpkg-dev > /dev/null 2>&1
	if [[ "$?" -eq "0" ]]; then
		echo -e $h"[+] dpkg-dev..........INSTALLED !"$n
	else
		echo -e $m"[-] dpkg-dev......NOT INSTALLED !"$n
		sleep 1
		echo "[!] Installing dpkg-dev ..."
		apt-get install dpkg-dev
		sleep 1
		clear
	fi

}
a_repo(){
a_repo_depen
echo "[+] Creating /repo directory ..."
mkdir -p /repo
sleep 1
echo "[+] Creating directory {/media/dvd1,/media/dvd2,/media/dvd3} ..."
mkdir -p /media/dvd1
mkdir -p /media/dvd2
mkdir -p /media/dvd3
sleep 1
echo "[+] Creating directory {/repo/pool/ ...} ..."
mkdir -p /repo/pool
mkdir -p /repo/dists/jessie/main/binary-amd64/
mkdir -p /repo/dists/jessie/main/source/
sleep 1
echo "[+]--- MOUNTING DVD1,DVD2,DVD3 --- [+]"
echo -n "[!] dvd1 path :"
read dvd1
echo -n "[!] dvd2 path :"
read dvd2
echo -n "[!] dvd3 path :"
read dvd3
if [[ $dvd1 != "" && $dvd2 != "" && $dvd3 != ""  ]]; then
	echo "[+] mountig $dvd1 to /media/dvd1 ..."
	mount -o loop $dvd1 /media/dvd1
	echo "[+] mountig $dvd2 to /media/dvd2 ..."
	mount -o loop $dvd2 /media/dvd2
	echo "[+] mountig $dvd3 to /media/dvd3 ..."
	mount -o loop $dvd3 /media/dvd3
	sleep 2
	echo "[+] Rsyncing dvd1 ..."
	rsync -avH /media/dvd1/pool /repo/pool
	echo "[+] Rsyncing dvd2 ..."
	rsync -avH /media/dvd2/pool /repo/pool
	echo "[+] Rsyncing dvd3 ..."
	rsync -avH /media/dvd3/pool /repo/pool
	sleep 1
	echo "[+] Change directory to /repo .."
	cd /repo
	if [[ `pwd` == "/repo" ]]; then
		echo "[+] Your in /repo directory ..."
		sleep 1
		echo "[+] packaging dvd1,dvd2,dvd3 ..."
	    dpkg-scanpackages ./dev/null | gzip -9c > Packages.gz
	    sleep 1
	    echo "[+] Resources dvd1,dvd2,dvd3 ..."
	    dpkg-scansources ./dev/null | gzip -9c > Sources.gz
	    sleep 1
	    echo "[+] Moving Packages.gz and Sources.gz ..."
	    mv Packages.gz /repo/dists/main/binary-amd64
	    sleep 1
	    mv Sources.gz /repo/dists/main/source/
	    sleep 1
	    echo "[+] Creating Symlink to /var/www/html/debian ..."
	    ln -s /repo /var/www/html/debian
	    sleep 1
	    echo "[+] Generating debian Repository ..."
	    echo -n "[+] Your Server Address : "
	    read addrez
	    regex_urlx=`echo $addrez | grep "http"`
	    if [[ "$regex_urlx" -eq "0" ]]; then
	    	clear
	    	echo "#--------- YOUR NEW REPOSITORY ----------"
	    	echo "deb $regex_urlx/debian jessie main"
	    	echo "deb-src $regex_urlx/debian jessie main"
	    	echo "#Repository Created by alinko kun <3"
	    else
	    	clear
	    	echo "#--------- YOUR NEW REPOSITORY ----------"
	    	echo "deb http://$addrez/debian jessie main"
	    	echo "deb-src http://$addrez/debian jessie main"
	    	echo "#Repository Created by alinko kun <3"
	    fi
	 else
	 	echo "[+] exit ..."
	 	echo -n "[!] Making Repository failed ! , what you want clean ? [Y/n] "
	 	read cleanx
	 	if [[ $cleanx == "y" || $cleanx == "Y" || $cleanx == "" ]]; then
	 		rm -rf /repo
	 		rm -rf /media/dvd1
	 		rm -rf /media/dvd2
	 		rm -rf /media/dvd3
	 		echo "[+] Cleaning Finished ..."
	 		exit 0
	 	fi
	fi
else
	echo "[!] Your DVD 1,2,3 not available ..."
	exit 0
fi
}
a_main(){
		clear
echo -e $n"             _______________          |*\_/*|________      "
echo -e $n"            |  ___________  |  $k G $n   ||_/-\_|______  |     "
echo -e $n"            | |   >   <   | |  $k  A $n  | |   0   <   | |     "
echo -e $n"            | |     -     | |  $k N $n   | |     -     | |     "
echo -e $n"            | |   \___/   | |  $k  D $n  | |   \___/   | |     "
echo -e $n"            |_____|\_/|_____| $k A   $n  |_______________|     "
echo -e $n"             / ********** \....."$k"."$n"..... / ********** \      "
echo -e $n"           /  ************  \        /  ************  \    "
echo -e $n"          --------------------      --------------------   "
echo -e $n"         +-----------------------------------------------+ "
echo -e $n"         |     -[$m Debian Server "$n"|    $b Auto Tools$n ]-  |"
echo -e $n"         |      $m  Author   :$k Ganda || guwePRO || pansakom$n|"
echo -e $n"         |      $m  Version  :$k 2.0 IDLICOS  $n               |"
echo -e $n"         |      $m Codename  :$k PEMALAS  $n                   |"
echo -e $n"         |$b   guwe.pro -$h Learn Linux And Develops  $n   |"
echo -e $n"         +-----------------------------------------------+ "   
echo -e $m">]=======])"$b"---------------------------------------------"$m"([=======[<"$n
echo -e $n"["$b"1"$n"]$h Configure Network.           "$k" ~ "$n"["$b"11"$n"]$h DNS Server (bind9) "
echo -e $n"["$b"2"$n"]$h Configure Repository.        "$k" ~ "$n"["$b"12"$n"]$h Mail Server & Webmail "
echo -e $n"["$b"3"$n"]$h Check Hostname & Hostname -f "$k" ~ "$n"["$b"13"$n"]$h Radio Server (icecast2) "
echo -e $n"["$b"4"$n"]$h Configure locales            "$k" ~ "$n"["$b"14"$n"]$h Install Monitorix"
echo -e $n"["$b"5"$n"]$h Install NTP and Configure NTP"$k" ~ "$n"["$b"15"$n"]$h Install Webmin"
echo -e $n"["$b"6"$n"]$h Configure bash.bashrc        "$k" ~ "$n"["$b"16"$n"]$h VoIP (asterisk)"
echo -e $n"["$b"7"$n"]$h Auto Install WebServer       "$k" ~ "$n"["$b"17"$n"]$h Install Nagios3"
echo -e $n"["$b"8"$n"]$h Activate SSL (HTTPS)         "$k" ~ "$n"["$b"18"$n"]$h Install CMS"
echo -e $n"["$b"9"$n"]$h Samba Server                 "$k" ~ "$n"["$b"19"$n"]$h Make Repository Debian with DVD"
echo -e $n"["$b"10"$n"]$h FTP Server (Proftpd)        "$k" ~ "$n"["$b"20"$n"]$k Update debsetool"
echo -e -n $m"guwe"$k"@"$b"pansakom$n : "
read pil
if [[ $pil == "1" ]]; then
	a_confnet
	a_main
elif [[ $pil == "2" ]]; then
	a_confrep
	a_main
elif [[ $pil == "3" ]]; then
	a_hostx
	a_main
elif [[ $pil == "4" ]]; then
	a_localex
	a_main
elif [[ $pil == "5" ]]; then
	a_intntp
	a_main
elif [[ $pil == "6" ]]; then
	nano /etc/bash.bashrc
	a_main
elif [[ $pil == "7" ]]; then
	a_webserv
	a_main
elif [[ $pil == "8" ]]; then
	a_sslx
	a_main
elif [[ $pil == "9" ]]; then
	a_samba
	a_main
elif [[ $pil == "10" ]]; then
	a_fptd
	a_main
elif [[ $pil == "11" ]]; then
	a_dnsx
	a_main
elif [[ $pil == "12" ]]; then
	a_mailx
	a_main
elif [[ $pil == "13" ]]; then
	a_radiox
	a_main
elif [[ $pil == "14" ]]; then
	a_monitorix
	a_main
elif [[ $pil == "15" ]]; then
	a_webmin
	a_main
elif [[ $pil == "16" ]]; then
	a_asterisk
	a_main
elif [[ $pil == "17" ]]; then
	a_nagios3
	a_main
elif [[ $pil == "18" ]]; then
	a_cms
	a_main
elif [[ $pil == "19" ]]; then
	a_repo
	a_main
elif [[ $pil == "20" ]]; then
	a_updatex
	a_main
else
	clear 
	a_main

fi
}
if [[ `whoami` == 'root' ]]; then
	a_main
else
	clear
	echo "[+] You Must Be root."
fi
