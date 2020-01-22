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

if [ $dia -gt "10" ]
then
        diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

touch $ano$mesn$diaant/planilha.csv
echo "





























" > $ano$mesn$diaant/planilha.csv

ipsproc=`cat $ano$mesn$diaant/ips.txt`

for ip in $ipsproc
do
	grep -R $ip $ano$mesn$diaant/*-$ano-* | cut -d '-' -f 4 | awk '{print$1,$2}' | sed 's/:/,/' > $ano$mesn$diaant/$ip.ok
	sed -i 's/$/;&/' $ano$mesn$diaant/$ip.ok
	echo "" >> $ano$mesn$diaant/$ip.ok
	for hora in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
	do
		hit=`cat $ano$mesn$diaant/$ip.ok | grep "$hora," | wc -l`
		if [ $hora -eq "08" ]; then
			linha=9
		else
		 	if [ $hora -eq "09" ]; then
                        	linha=10
	                else
				linha=`echo $(($hora+1))`
			fi
		fi
		if [ $hit -eq 0 ]; then
			sed -i "$linha i $hora, 0;" $ano$mesn$diaant/$ip.ok
		else
			echo " " > /dev/null
		fi
	done
	sed -i '/^$/d' $ano$mesn$diaant/$ip.ok
	sed -i "1 i hora, $ip;" $ano$mesn$diaant/$ip.ok
	cat $ano$mesn$diaant/$ip.ok | awk '{print$2,$3}' >> $ano$mesn$diaant/$ip.okok
	rm -rf $ano$mesn$diaant/$ip.ok
	mv $ano$mesn$diaant/$ip.okok $ano$mesn$diaant/$ip.ok
	for line in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
	do
		linhaadd=`awk "FNR==$line" $ano$mesn$diaant/$ip.ok`
		sed -i "$line s/$/ $linhaadd/" $ano$mesn$diaant/planilha.csv
	done
done
sed -i "1 s/^/Hora;/" $ano$mesn$diaant/planilha.csv
sed -i "2 s/^/0;/" $ano$mesn$diaant/planilha.csv
sed -i "3 s/^/1;/" $ano$mesn$diaant/planilha.csv
sed -i "4 s/^/2;/" $ano$mesn$diaant/planilha.csv
sed -i "5 s/^/3;/" $ano$mesn$diaant/planilha.csv
sed -i "6 s/^/4;/" $ano$mesn$diaant/planilha.csv
sed -i "7 s/^/5;/" $ano$mesn$diaant/planilha.csv
sed -i "8 s/^/6;/" $ano$mesn$diaant/planilha.csv
sed -i "9 s/^/7;/" $ano$mesn$diaant/planilha.csv
sed -i "10 s/^/8;/" $ano$mesn$diaant/planilha.csv
sed -i "11 s/^/9;/" $ano$mesn$diaant/planilha.csv
sed -i "12 s/^/10;/" $ano$mesn$diaant/planilha.csv
sed -i "13 s/^/11;/" $ano$mesn$diaant/planilha.csv
sed -i "14 s/^/12;/" $ano$mesn$diaant/planilha.csv
sed -i "15 s/^/13;/" $ano$mesn$diaant/planilha.csv
sed -i "16 s/^/14;/" $ano$mesn$diaant/planilha.csv
sed -i "17 s/^/15;/" $ano$mesn$diaant/planilha.csv
sed -i "18 s/^/16;/" $ano$mesn$diaant/planilha.csv
sed -i "19 s/^/17;/" $ano$mesn$diaant/planilha.csv
sed -i "20 s/^/18;/" $ano$mesn$diaant/planilha.csv
sed -i "21 s/^/19;/" $ano$mesn$diaant/planilha.csv
sed -i "22 s/^/20;/" $ano$mesn$diaant/planilha.csv
sed -i "23 s/^/21;/" $ano$mesn$diaant/planilha.csv
sed -i "24 s/^/22;/" $ano$mesn$diaant/planilha.csv
sed -i "25 s/^/23;/" $ano$mesn$diaant/planilha.csv

rm -rf $ano$mesn$diaant/*-$ano-*
rm -rf $ano$mesn$diaant/*.ok
rm -rf $ano$mesn$diaant/access_portal_log-"$ano$mesn$diaant"_nginx
