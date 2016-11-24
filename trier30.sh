tempsTotal=0
tempsTotalCPUUser=0
tempsTotalCPUSys=0

tri_seq(){
	res=$(echo $taille | ./tri_sequentiel  --quiet --time --rusage)
	temps=$(echo $res | cut -d, -f1)
	tempsUser=$(echo $res | cut -d, -f2)
	tempsSys=$(echo $res | cut -d, -f3)
	tempsTotal=$(($temps + $tempsTotal))
	tempsTotalCPUUser=$(($tempsTotalCPUUser + $tempsUser))
	tempsTotalCPUSys=$(($tempsTotalCPUSys + $tempsSys))
	resultat="$taille,$res"
	echo $resultat >> resultat30.dat
}

tri_threads(){
	res=$(echo $taille | ./tri_threads --parallelism $threads --quiet --time --rusage)
	resultat="$taille,$res"
	echo $resultat
}

echo -n "taille du vecteur ?"
read taille;

echo -n "nombre de threads ?"
read threads

#echo "#Première colonne, taille du vecteur" >> resultat30.dat
#echo "#Deuxieme colonne, tempsMoyen(gettimeofday)" >> resultat30.dat
#echo "#Troisième colonne, tempsMoyen(ru_utime)" >> resultat30.dat
#echo "#Quatrième colonne, tempsMoyen(ru_stime)" >> resultat30.dat
for (( c=1; c<=30; c++))
do 
	tri_seq
	#tri_threads
done

tempsMoy=$(($tempsTotal/30))
tempsMoyCPUUser=$(($tempsTotalCPUUser/30))
tempsMoyCPUSys=$(($tempsTotalCPUSys/30))
echo "$taille,$tempsMoy,$tempsTotalCPUUser,$tempsMoyCPUSys"

exit 0
