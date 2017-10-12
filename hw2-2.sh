#!/bin/sh
fir=$(curl -c cookie.txt https://portal.nctu.edu.tw/captcha/pic.php)
sec=$(curl -b cookie.txt -o b.png https://portal.nctu.edu.tw/captcha/pitctest/pic.php)
picpw=$(curl -X POST -F 'image=@b.png' https://nasa.cs.nctu.edu.tw/sap/2017/hw2/captcha-solver/api/)

while [ "$picpw" == "ERROR: Can NOT recognize, try other." ]
do	
	echo "$picpw"
	fir=$(curl -c cookie.txt https://portal.nctu.edu.tw/captcha/pic.php)
	sec=$(curl -b cookie.txt -o b.png https://portal.nctu.edu.tw/captcha/pitctest/pic.php)
	picpw=$(curl -X POST -F 'image=@b.png' https://nasa.cs.nctu.edu.tw/sap/2017/hw2/captcha-solver/api/)
done
echo "$picpw"

account=$(dialog --title "Account" --no-shadow --inputbox "Enter your account" 0 0 3>&1 1>&2 2>&3 3>&-)
password=$(dialog --title "Password" --no-shadow --insecure --passwordbox "Enter your password" 0 0 3>&1 1>&2 2>&3 3>&-)
echo "$account"
echo "$password"

curl  --data "username=$account&password=$password&seccode=$picpw&pwdtype=static&Submit2=登入(Login)" -b cookie.txt https://portal.nctu.edu.tw/portal/chkpas.php?
#curl -i --header "Accept:application/json" -X GET -b ~/cookie.txt https://portal.nctu.edu.tw/portal/relay.php?D=cos
curl -b cookie.txt -o course.html https://portal.nctu.edu.tw/portal/relay.php?D=cos 
#curl -D cookie1.txt https://portal.nctu.edu.tw/portal/relay.php?D=cos
curl  -b cookie1.txt -o page.html https://course.nctu.edu.tw/adSchedule.asp 