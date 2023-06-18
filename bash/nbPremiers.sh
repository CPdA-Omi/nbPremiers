#!/bin/bash

premier=true
cpt=0
cptLine=0
min=$1
max=$2
nbPerLine=10

if [ $# -ne 1 -a $# -ne 2 ]; then # $#>2 or $#<1
	echo "Erreur, fournir UN ou DEUX arguments." >&2
	exit 1

elif [ $# -eq 1 ]; then # only one number
	if [ $min -eq 1 -o $min -eq 2 -o $min -eq 3 ]; then
		echo "$min est un nombre premier"
		exit 0
	else
		if [ $(($min%2)) -ne 0 ]; then
			premier=true
			sqrt=`echo "scale=0; sqrt($min)" | bc`
			for i in $( seq 3 2 $(($sqrt+1)) ); do
				if [ $(($min%$i)) -eq 0 ]; then
					premier=false
					break
				fi
			done
			if [ $premier == true ]; then
				echo "$min est un nombre premier"
				exit 0
			fi
		fi
	fi
	echo "$min n'est pas un nombre premier"
	exit 0

elif [ $min -lt 1 -o $max -lt 1 -o $min -gt $max ]; then # $min<1 or $max<1 or $min>$max
	echo "Erreur, nombres invalides." >&2
	exit 1
fi

if [ $min -eq 1 -a $max -gt 2 ]; then
	min=$(($min+1))
fi

echo -e "Nombres premiers entre $min et $max\n"

for i in $(seq $min 1 $max); do # multiple valid numbers
	if [ $i -eq 2 -o $i -eq 3 -o $i -eq 5 ]; then
		echo -ne "\t$i"
		cpt=$(($cpt+1))
		cptLine=$(($cptLine+1))
		continue
	else
		if [ $(($i%2)) -ne 0 -a $(($i%5)) -ne 0 ]; then # $i is not pair or not multiple of 5
			premier=true
			if [ $cptLine -gt $(($nbPerLine-1)) ]; then
				echo ""
				cptLine=0
			fi
			sqrt=`echo "scale=0; sqrt($i)" | bc`
			for j in $( seq 3 2 $(($sqrt+1)) ); do
				if [ $(($i%$j)) -eq 0 ]; then
					premier=false
					break
				fi
			done
			if [ $premier == true ]; then
				echo -ne "\t$i"
				cpt=$(($cpt+1))
				cptLine=$(($cptLine+1))
			fi
		fi
	fi
done

echo -e "\n\nNombres premiers : $cpt"
