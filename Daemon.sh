#!/bin/bash
while ((1))
do sleep 60
if (ps -A | grep ssserver > /dev/null)
then :
else ssserver -c /etc/shadowsocks/config.json -d start
fi
done