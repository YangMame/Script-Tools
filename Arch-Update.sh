#!/bin/bash
sleep 20
DECIDE(){
sleep 30
while (cat /tmp/arch.log | grep "(*)")
do notify-send "HEY !" "Your System Need To Upgrade !"
killall pacaur
sudo rm -f /var/lib/pacman/db.lck
sleep 900
pacaur -Syu > /tmp/arch.log & DECIDE
done
sudo rm -f /var/lib/pacman/db.lck
}

while ((1))
do sudo rm -f /var/lib/pacman/db.lck
pacaur -Syu > /tmp/arch.log & DECIDE
sleep 1800
done
