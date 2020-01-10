#!/bin/bash

ano=`date +%Y`
mes=`date +%b`
dia=`date +%e`
mesn=`date +%m`
logs='/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX'

if [ $dia -gt "10" ]
then
        diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

ips=`cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mesn$diaant/lista.txt"`

for nginx in 15 16
do
        mkdir -p "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mesn$diaant"
        echo $nginx > /dev/null
done

for hora in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23;
do
        sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mesn$diaant/access_portal_log-"$ano""$mesn""$diaant"_sinvp-0$nginx" | grep "$ips" | grep $diaant/$mes/$ano:$hora | awk '{print$1}' | uniq -c | sort -n -t: -k1 | tail -n20 > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mesn$diaant/$diaant-$mesn-$ano-$hora"
done
sh create_csv.sh
