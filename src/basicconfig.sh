#!/bin/bash

# +--=== -[[ DebSetool v0.3 IndonesianPeople
# +--=== -[[ Author  : shutdownz guwePRO ganda
# +--=== -[[ Contact : gsinarna@gmail.com
# +--=== -[[ Website : www.guwe.pro 
# +--=== -[[ This Software Under General Public License v3
# +--=== -[[ Greeting: BLC Telkom Klaten - KPLI Klaten - guwe.pro


m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
n="\033[1;0m"
adeb_basicconfig_hostname(){
echo "+---=== [[ Hostname   :`hostname` "
echo "+---=== [[ /etc/hosts : `hostname -f`"
echo -n "+---=== [[ Change Hostname :"
read ahostname
echo $ahostname > /etc/hostname
echo -n "+---=== [[ Change /etc/hosts ? [y/n] "
read ahosts
if [[ $ahosts == "y" || $ahosts == "Y" ]]; then
	echo -n " *--|| Old Hosts : "
	read aoh
	echo -n " *--|| New Hosts : "
	read anh
	sed -i 's/'$aoh'/'$anh'/g' /etc/hosts
fi

echo -n "[+] whether your configuration is correct? [Y/n]"
read awhy
if [[ $awhy == "Y" || $awhy == "y" || $awhy == "" ]]; then
	adeb_basicconfig
else
	nano /etc/hosts
fi
a_btmenu adeb_basicconfig
}
adeb_basicconfig_repo(){
echo -n "[+] Do you want to manually configure repositories? [Y/n] "
read acfgrp
if [[ $acfgrp == "Y" || $acfgrp == "y" || $acfgrp == "" ]]; then
	nano /etc/apt/sources.list
	echo -n "[+] Do you want to update ? [Y/n] "
	read aupt
	if [[ $aupt == "Y" || $aupt == "y" || $aupt == "" ]]; then
		apt-get update -y
	fi
else
	clear
echo "[+] Checking Dependecies ..."
which dialog > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	arepo=$(dialog --title "[+] DebSetool v0.3 - Select Repository" --fselect $a_repo_path/official-ubuntu-16.repo 13 50 3>&1 1>&2 2>&3 3>&1)
	echo "# Repository Add by ganda . guwePRO shutdownz" >> /etc/apt/sources.list
	echo "# DebSetool v0.3 - IndonesianPeople " >> /etc/apt/sources.list
	cat $arepo >> /etc/apt/sources.list
else
	echo "[+] Dependensi \"dialog\" command not found ..."
	echo "[+] Try apt-get install dialog :*"
fi

echo -n "[+] Do you want update ? [Y/n]"
read auptd
if [[ $auptd == "Y" || $auptd == "y" || $auptd == "" ]]; then
	apt-get update -y
fi
fi
a_btmenu adeb_basicconfig
}
adeb_basicconfig_ntp(){
clear
echo "[+] Installing ntp ..."
apt-get install ntp -y
echo "[!] Configure /etc/ntp.conf ..."
cat /etc/ntp.conf | grep ".debian." > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	echo "[+] Found NTP Config ..."
	cat /etc/ntp.conf | grep ".debian."
	echo -n "+---=== [[ Replace debian ntp to ? :"
	read intp
	sed -i 's/debian/'$intp'/g' /etc/ntp.conf
	cat /etc/ntp.conf | grep $intp > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo "[+] Replaced to $intp .."
		cat /etc/ntp.conf | grep $intp
	else
		echo "[+] Failed replace :( "
		echo -n "[+] Do you want configure manually ? [Y/n]"
		read yn
		if [[ $yn == "Y" || $yn == "y" || $yn == "" ]]; then
			nano /etc/ntp.conf
		fi
	fi
else
	cat /etc/ntp.conf | grep ".ubuntu." > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo "[+] Found NTP Config ..."
		cat /etc/ntp.conf | grep ".ubuntu."
		echo -n "+---=== [[ Replace ubuntu ntp to ? :"
		read intpu
		sed -i 's/ubuntu/'$intpu'/g' /etc/ntp.conf
		cat /etc/ntp.conf | grep $intpu > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			echo "[+] Replaced to $intpu .."
			cat /etc/ntp.conf | grep $intpu
		else
			echo "[+] Failed replace :( "
			echo -n "[+] Do you want configure manually ? [Y/n]"
			read yn
			if [[ $yn == "Y" || $yn == "y" || $yn == "" ]]; then
				nano /etc/ntp.conf
			fi
		fi
	fi
fi

a_btmenu adeb_basicconfig
}
adeb_basicconfig_ip(){
clear
echo -n "[+] Do you want to manually configure Network ? [Y/n]"
read anet
if [[ $anet == "y" || $anet == "Y" || $anet == "" ]]; then
	nano /etc/network/interfaces
	echo -n "[+] Do You Want Restart Network service ? [Y/n] "
	read ans
	if [[ $ans == "Y" || $ans == "y" || $ans == "" ]]; then
		clear
		echo "[+] Restarting Network ..."
		/etc/init.d/networking restart
		sleep 1
	fi
else
	echo "[+] Auto config"
fi
a_btmenu adeb_basicconfig
}
adeb_locale(){
clear
echo "[+] ReConfigure Locales ..."
sleep 0.6
dpkg-reconfigure locales1
echo "[+] Generating Locales ..."
sleep 0.8
locale-gen
a_btmenu adeb_basicconfig
}
adeb_basicconfig(){
	clear
echo -e $m"  ____            _      "$k" _____             __ _        "$n
echo -e $m" |  _ \          (_)     "$k"/ ____|           / _(_)       "$n
echo -e $m" | |_) | __ _ ___ _  ___|"$k" |     ___  _ __ | |_ _  __ _  "$n
echo -e $m" |  _ < / _' / __| |/ __|"$k" |    / _ \\| '_ \|  _| |/ _' | "$n
echo -e $m" | |_) | (_| \__ \ | (__|"$k" |___| (_) | | | | | | | (_| | "$n
echo -e $h" |____/ \__,_|___/_|\___|"$b"\_____\___/|_| |_|_| |_|\__, | "$n
echo -e $h"                         "$b"                         __/ | "$n
echo -e $h"                         "$b"                        |___/  "$n
echo -e "@ +--=== [[ Basic Configuration For Debian,Ubuntu Server."
echo -e "@ +--=== [[ Debstool v0.3 IndonesianPeople."
echo ""
echo -e "["$m"1"$n"]$k Configure Hostname"$n
echo -e "["$m"2"$n"]$k Configure Repository"$n
echo -e "["$m"3"$n"]$k Install NTP & Configure"$n
echo -e "["$m"4"$n"]$k IP Configuration"$n
echo -e "["$m"5"$n"]$k Configure Locales"$n
echo -e "["$m"99"$n"]$k Back to menu"$n

echo -e -n "debsetool@basic_config >> "
read debsganda2
if [[ $debsganda2 == "1" ]]; then

	adeb_basicconfig_hostname


elif [[ $debsganda2 == "2" ]]; then

	adeb_basicconfig_repo


elif [[ $debsganda2 == "3" ]]; then

	adeb_basicconfig_ntp


elif [[ $debsganda2 == "4" ]]; then

	adeb_basicconfig_ip
elif [[ $debsganda2 == "5" ]]; then
	adeb_locale

elif [[ $debsganda2 == "99" ]]; then
	a_main
else
	adeb_basicconfig
fi
}
