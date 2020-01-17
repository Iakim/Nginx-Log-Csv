ano=`date +%Y`
mes=`date +%b`
dia=`date +%e`
mesn=`date +%m`
pasta="/home/isaac/ISAAC - DOCS/IMPRENSA/NGINX"

if [ $dia -gt "10" ]
then
        diaant=`echo $(($dia-1))`
else
        zero="0"
        diaant=`echo $zero$(($dia-1))`
fi

touch "$pasta"/$ano$mesn$diaant/planilha.csv
echo "
























" > "$pasta"/$ano$mesn$diaant/planilha.csv

ipsproc=`cat "$pasta"/$ano$mesn$diaant/ips.txt`

for ip in $ipsproc
do
	grep -R $ip "$pasta"/$ano$mesn$diaant/*-$ano-* | cut -d '-' -f 4 | awk '{print$1,$2}' | sed 's/:/,/' > "$pasta"/$ano$mesn$diaant/$ip.ok
	sed -i 's/$/;&/' "$pasta"/$ano$mesn$diaant/$ip.ok
	echo "" >> "$pasta"/$ano$mesn$diaant/$ip.ok
	for hora in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
	do
		hit=`cat "$pasta"/$ano$mesn$diaant/$ip.ok | grep "$hora," | wc -l`
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
			sed -i "$linha i $hora, 0;" "$pasta"/$ano$mesn$diaant/$ip.ok
		else
			echo " " > /dev/null
		fi
	done
	sed -i '/^$/d' "$pasta"/$ano$mesn$diaant/$ip.ok
	sed -i "1 i hora, $ip;" "$pasta"/$ano$mesn$diaant/$ip.ok
	cat "$pasta"/$ano$mesn$diaant/$ip.ok | awk '{print$2,$3}' >> "$pasta"/$ano$mesn$diaant/$ip.okok
	rm -rf "$pasta"/$ano$mesn$diaant/$ip.ok
	mv "$pasta"/$ano$mesn$diaant/$ip.okok "$pasta"/$ano$mesn$diaant/$ip.ok
	for line in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
	do
		linhaadd=`awk "FNR==$line" "$pasta"/$ano$mesn$diaant/$ip.ok`
		sed -i "$line s/$/ $linhaadd/" "$pasta"/$ano$mesn$diaant/planilha.csv
	done
done
rm -rf "$pasta"/$ano$mesn$diaant/*-$ano-*
rm -rf "$pasta"/$ano$mesn$diaant/*.ok
