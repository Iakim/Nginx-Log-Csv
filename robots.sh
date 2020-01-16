#!/bin/bash

ano=`date +%Y`
mes=`date +%b`
dia=`date +%e`
mesn=`date +%m`
logs='/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX'
under='_nginx'

if [ $dia -gt "10" ]
then
        diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

ips=`sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mesn$diaant/lista.txt"`

for hora in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23;
do
	comando="sort '$logs/$ano$mesn$diaant/access_portal_log-$ano$mesn$diaant$under' | grep $ips | grep $diaant/$mes/$ano:$hora | awk '{print\$1}' | uniq -c | sort -n -t: -k1 > '$logs/$ano$mesn$diaant/$diaant-$mesn-$ano-$hora'"
	echo "$comando" > comando.sh
	sh comando.sh
done
rm -rf comando.sh
sh create_csv.sh
