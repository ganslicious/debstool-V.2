#!/bin/bash

# +--=== -[[ DebSetool v0.3 IndonesianPeople
# +--=== -[[ Author  : shutdownz guwePRO ganda
# +--=== -[[ Contact : gsinarna@gmail.com
# +--=== -[[ Website : www.guwe.pro 
# +--=== -[[ This Software Under General Public License v3
# +--=== -[[ Greeting: BLC Telkom Klaten - KPLI Klaten - guwe.pro

adeb_cms_cekws(){
	echo "[+] Checking Apache2 ..."
	dpkg -l | grep apache2 > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo "[+] Apache2 Installed ."
	else
		echo "[+] Apache2 Not Installed ."
	fi
	echo "[+] Checking Nginx ..."
	dpkg -l | grep nginx > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo "[+] Nginx Installed ."
	else
		echo "[+] Nginx Not Installed ." 
	fi
	a_btmenu adeb_cms
}
adeb_cms_wrp(){
	cek_ada="/etc/debsetool/debsetool-ws.conf"
	if [[ ! -f $cek_ada ]]; then
		echo " +---=== [[ Set Webserver Directory."
		echo " +---=== [[ Default : /var/www/html."
		sleep 0.5
		echo -n "Webserver Dir :"
		read awd
		echo "[+] Setup Webdir ..."
		sleep 1
		touch /etc/debsetool/debsetool-ws.conf
		echo "# Webserver Directory . " >> /etc/debsetool/debsetool-ws.conf
		echo "webdir="$awd >> /etc/debsetool/debsetool-ws.conf
		echo "[+] Done . Directory Webserver : "$awd
		echo ""
	else
		source /etc/debsetool/debsetool-ws.conf
		echo "[+] directory webserver already configured :"$webdir
	fi
	a_btmenu adeb_cms
}
adeb_cms_wp(){
	echo -n "[+] Do You Want Check webserver & Webserver directory ? [Y/n] "
	read awpr
	if [[ $awpr == "y" || $awpr == "Y" || $awpr == "" ]]; then
		adeb_cms_cekws
		adeb_cms_wrp
	fi
	a_btmenu adeb_cms
}

adeb_cms(){
	clear
echo -e $b"      ___      "$n"     ___ Manag"$k"ement___      "$n
echo -e $b"     /  /\     "$n"    /__/\     "$k"    /  /\System"$n
echo -e $b"    /  /:/Conte"$n"nt |  |::\    "$k"   /  /:/_    "$n
echo -e $b"   /  /:/      "$n"   |  |:|:\   "$k"  /  /:/ /\   "$n
echo -e $b"  /  /:/  ___  "$n" __|__|:|\:\  "$k" /  /:/ /::\  "$n
echo -e $b" /__/:/  /  /\ "$n"/__/::::| \:\ "$k"/__/:/ /:/\:\ "$n
echo -e $b" \  \:\ /  /:/ "$n"\  \:\~~\__\/ "$k"\  \:\/:/~/:/ "$n
echo -e $b"  \  \:\  /:/  "$n" \  \:\       "$k" \  \::/ /:/  "$n
echo -e $b"   \  \:\/:/   "$n"  \  \:\      "$k"  \__\/ /:/   "$n
echo -e $b"    \  \::/    "$n"   \  \:\     "$k"    /__/:/    "$n
echo -e $b"     \__\/     "$n"    \__\/     "$k"    \__\/     "$n
echo -e $m"+---------------------------------------+"$n
echo -e $k"+--------------------------------------+"$n
echo -e $h"+-------------------------------------+"$n
echo -e "@ +--=== [[ CMS Install For Debian,Ubuntu Server."
echo -e "@ +--=== [[ DebSetool v0.3 IndonesianPeople."   
echo ""
echo -e $n"["$m"0"$n"]$k Check Webserver Installed."
echo -e $n"["$m"1"$n"]$k Set Webserver Root Path"
echo -e $n"["$m"2"$n"]$k Wordpress"
echo -e $n"["$m"3"$n"]$k PopojiCMS"
echo -e $n"["$m"4"$n"]$k alinkoCMS beta"
echo -e $n"["$m"5"$n"]$k cmsDesaKu [YogiBimaCMS]"
echo -e $n"["$m"6"$n"]$k Moodle"
echo -e $n"["$m"7"$n"]$k Joomla"
echo -e $n"["$m"8"$n"]$k Drupal"
echo -e $n"["$m"99"$n"]$k Back to menu"$n
echo -e -n "debsetool@cms >>"
read acms
if [[ $acms == "99" ]]; then
	a_main
elif [[ $acms == "0" ]]; then
	adeb_cms_cekws
	
elif [[ $acms == "1" ]]; then
	adeb_cms_wrp
	
elif [[ $acms == "2" ]]; then
	adeb_cms_wp
	
fi
}
