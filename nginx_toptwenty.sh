#!/bin/bash

ano=`date +%Y`
mes=`date +%m`
dia=`date +%e`

if [ $dia -gt "10" ]
then
	diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

mkdir -p "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant"

for nginx in 15 16;
do
	scp root@sinvp-0$nginx.in.local:/var/log/nginx/access_portal_log-"$ano""$mes""$diaant"_sinvp-0$nginx "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant"
done

cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-015" >> "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-016"
mv "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-016" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_nginx"

sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_nginx" | awk '{print$1}' | uniq -c | sort -n -t: -k1 | tail -n20 > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/"$ano""$mes""$diaant"_nginx.txt"
sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/"$ano""$mes""$diaant"_nginx.txt" | awk '{print$2}' >> "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista0.txt"

sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista0.txt" | uniq -c > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista00.txt"
cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista00.txt" | awk '{print$2}' >> "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt"
cp "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/ips1.txt"
cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/ips1.txt" | awk 'BEGIN { ORS = " " } { print }' > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/ips.txt"
sed -i 's/$/ \\| &/' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt" 
cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt" | awk 'BEGIN { ORS = " " } { print }' > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i -r 's/\s+//g' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i 's/.\{2\}$//' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i "s/$/'&/" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i "s/^/'/" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"

rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-015"
rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista0.txt"
rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista00.txt"
rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt"
rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/ips1.txt"
sh robots.sh
