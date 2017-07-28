#! /bin/bash
IP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
read -p "Install shadowsocks ? (n or ENTER " TMP
if [ "$TMP" == "" ]
then apt install python python-pip -y
    pip install shadowsocks
    read -p "Input your password : " PASSWD
    echo "{
	    \"server\":\"$IP\",
	    \"server_port\":8388,
	    \"local_address\": \"127.0.0.1\",
	    \"local_port\":1080,
	    \"password\":\"$PASSWD\",
	    \"timeout\":300,
	    \"method\":\"aes-256-cfb\"
	}
    " > /etc/ss-config.json
    ssserver -c /etc/ss-config.json -d start
    echo -e "\033[31m ********************************************** \033[0m"
    echo "Your ss config is : "
    cat /etc/ss-config.json
fi
echo -e "\033[31m ********************************************** \033[0m"
read -p "ENTER to continue "

read -p "Install shadowsocks r ? (n or ENTER " TMP
if [ "$TMP" == "" ]
then apt install git python -y
git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git
cd shadowsocksr&&bash initcfg.sh&&cd shadowsocks
read -p "Input your passworld : " PASSWD
read -p "Input the port you wanna to use :  " PORT
python server.py -p $port -k $PASSWD -m aes-256-cfb -O auth_sha1_v4 -o http_simple -d start
echo -e "\033[31m ********************************************** \033[0m"
echo "Your ssr config is : "
echo "IP : $IP
Port : $PORT
Passworld : $PASSWD
Encryption : aes-256-cfb
Protocol plugin : auth_sha1_v4
Confused : http_simple"
echo -e "\033[31m ********************************************** \033[0m"
read -p "ENTER to continue "

read -p "Use the aria2 webui ? (n or ENTER " TMP
if [ "$TMP" == "" ]
then apt install aria2 nginx -y
    git clone https://github.com/ziahamza/webui-aria2.git
    cp -rf webui-aria2/* /var/www/html/
    read -p "Input user name : " USER
    read -p "Input passwd : " PASSWD
    aria2c --enable-rpc --rpc-listen-all --rpc-user=$USER --rpc-passwd=$PASSWD -D
fi
service nginx start&&systemctl enable nginx
read -p "ENTER to continue "

read -p "install ftp ? (n or ENTER " TMP
if [ "$TMP" == "" ]
then apt install vsftpd-y
    service vsftpd start&&systemctl enable vsftpd
fi
echo "Done ! thanks fo using !"
