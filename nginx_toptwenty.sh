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

for nginx in 15 16
do
        mkdir -p "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant"
        scp root@sinvp-0$nginx.in.local:/var/log/nginx/access_portal_log-"$ano""$mes""$diaant"_sinvp-0$nginx "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant"
done

for nginx in 15 16
do
        sort "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/access_portal_log-"$ano""$mes""$diaant"_sinvp-0$nginx" | awk '{print$1}' | uniq -c | sort -n -t: -k1 | tail -n20 > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/"$ano""$mes""$diaant"_sinvp-0$nginx.txt"
        cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/"$ano""$mes""$diaant"_sinvp-0$nginx.txt" | awk '{print$2}' >> "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt"
done

sed -i 's/$/ \\| &/' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt"
cat "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt" | awk 'BEGIN { ORS = " " } { print }' > "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i -r 's/\s+//g' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i 's/.\{2\}$//' "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i "s/$/'&/" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
sed -i "s/^/'/" "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista.txt"
rm -rf "/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX/$ano$mes$diaant/lista1.txt"
