#!/bin/bash
###################################################################################
## Nginx-Log-Csv 						   		 ##
## Script bash for create a graph from csv of processing of logs nginx/apache	 ##
## Author: https://github.com/Iakim 				    		 ##
## Simplicity is the ultimate degree of sophistication		    		 ##
###################################################################################

ano=`date +%Y`
mes=`date +%b`
dia=`date +%e`
mesn=`date +%m`
under='_nginx'
pasta="/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX"

if [ $dia -gt "10" ]
then
        diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

ips=`sort "$pasta/$ano$mesn$diaant/lista.txt"`

for hora in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23;
do
	comando="sort '$pasta/$ano$mesn$diaant/access_portal_log-$ano$mesn$diaant$under' | grep $ips | grep $diaant/$mes/$ano:$hora | awk '{print\$1}' | uniq -c | sort -n -t: -k1 > '$pasta/$ano$mesn$diaant/$diaant-$mesn-$ano-$hora'"
	echo "$comando" > "$pasta"/$ano$mesn$diaant/comando.sh
	sh "$pasta"/$ano$mesn$diaant/comando.sh
done
rm -rf "$pasta"/$ano$mesn$diaant/comando.sh
sh "$pasta"/create_csv.sh
