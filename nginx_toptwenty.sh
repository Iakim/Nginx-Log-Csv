#!/bin/bash
###################################################################################
## Nginx-Log-Csv 						   		 ##
## Script bash for create a graph from csv of processing of logs nginx/apache	 ##
## Author: https://github.com/Iakim 				    		 ##
## Simplicity is the ultimate degree of sophistication		    		 ##
###################################################################################

ano=`date +%Y`
mes=`date +%m`
dia=`date +%e`
pasta="/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX"

if [ $dia -gt "10" ]
then
	diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

mkdir -p "$pasta/$ano$mes$diaant"

for nginx in 15 16;
do
	scp root@sinvp-0$nginx.in.local:/var/log/nginx/access_portal_log-"$ano""$mes""$diaant"_sinvp-0$nginx "$pasta/$ano$mes$diaant"
done

cat "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-015" >> "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-016"
mv "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-016" "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_nginx"

sort "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_nginx" | awk '{print$1}' | uniq -c | sort -n -t: -k1 | tail -n20 > "$pasta/$ano$mes$diaant/"$ano""$mes""$diaant"_nginx.txt"
sort "$pasta/$ano$mes$diaant/"$ano""$mes""$diaant"_nginx.txt" | awk '{print$2}' >> "$pasta/$ano$mes$diaant/lista0.txt"

sort "$pasta/$ano$mes$diaant/lista0.txt" | uniq -c > "$pasta/$ano$mes$diaant/lista00.txt"
cat "$pasta/$ano$mes$diaant/lista00.txt" | awk '{print$2}' >> "$pasta/$ano$mes$diaant/lista1.txt"
cp "$pasta/$ano$mes$diaant/lista1.txt" "$pasta/$ano$mes$diaant/ips1.txt"
cat "$pasta/$ano$mes$diaant/ips1.txt" | awk 'BEGIN { ORS = " " } { print }' > "$pasta/$ano$mes$diaant/ips.txt"
sed -i 's/$/ \\| &/' "$pasta/$ano$mes$diaant/lista1.txt" 
cat "$pasta/$ano$mes$diaant/lista1.txt" | awk 'BEGIN { ORS = " " } { print }' > "$pasta/$ano$mes$diaant/lista.txt"
sed -i -r 's/\s+//g' "$pasta/$ano$mes$diaant/lista.txt"
sed -i 's/.\{2\}$//' "$pasta/$ano$mes$diaant/lista.txt"
sed -i "s/$/'&/" "$pasta/$ano$mes$diaant/lista.txt"
sed -i "s/^/'/" "$pasta/$ano$mes$diaant/lista.txt"

rm -rf "$pasta/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-015"
rm -rf "$pasta/$ano$mes$diaant/lista0.txt"
rm -rf "$pasta/$ano$mes$diaant/lista00.txt"
rm -rf "$pasta/$ano$mes$diaant/lista1.txt"
rm -rf "$pasta/$ano$mes$diaant/ips1.txt"
sh "$pasta"/robots.sh
