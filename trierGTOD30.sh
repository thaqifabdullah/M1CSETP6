#!/bin/bash
tempsTotalSeq=0
tempsTotalThreads1=0
tempsTotalThreads2=0
tempsTotalThreads4=0
tempsTotalThreads8=0
tempsTotalThreads16=0

#rusage
tempsRUserSeq=0
tempsRSysSeq=0

tri_seq(){
	res=$(echo $taille | ./tri_sequentiel  --quiet --time --rusage)
	temps=$(echo $res | cut -d, -f1)
	tempsTotalSeq=$(($temps + $tempsTotalSeq))
	tUser=$(echo $res | cut -d, -f2)
	tempsRUserSeq=$(($tUser + $tempsRUserSeq))
	tSys=$(echo $res | cut -d, -f3)
	tempsRSysSeq=$(($tSys + $tempsRSysSeq))
}

tri_threads1(){
	res=$(echo $taille | ./tri_threads --parallelism 1 --quiet --time --rusage)
	temps1=$(echo $res | cut -d, -f1)
	tempsTotalThreads1=$(($temps1 + $tempsTotalThreads1))
}

tri_threads2(){
	res=$(echo $taille | ./tri_threads --parallelism 2 --quiet --time --rusage)
	temps2=$(echo $res | cut -d, -f1)
	tempsTotalThreads2=$(($temps2 + $tempsTotalThreads2))
}

tri_threads4(){
	res=$(echo $taille | ./tri_threads --parallelism 4 --quiet --time --rusage)
	temps4=$(echo $res | cut -d, -f1)
	tempsTotalThreads4=$(($temps4 + $tempsTotalThreads4))
}

tri_threads8(){
	res=$(echo $taille | ./tri_threads --parallelism 8 --quiet --time --rusage)
	temps8=$(echo $res | cut -d, -f1)
	tempsTotalThreads8=$(($temps8 + $tempsTotalThreads8))
}

tri_threads16(){
	res=$(echo $taille | ./tri_threads --parallelism 16 --quiet --time --rusage)
	temps16=$(echo $res | cut -d, -f1)
	tempsTotalThreads16=$(($temps16 + $tempsTotalThreads16))
}

echo -n "taille du vecteur ?"
read taille;

#echo "#Première colonne, taille du vecteur" >> tempsMoyenGTOD.dat
#echo "#Deuxieme colonne, tempsMoyenSeq" >> tempsMoyenGTOD.dat
#echo "#Troisième colonne, tempsMoyenThreads1" >> tempsMoyenGTOD.dat
#echo "#Quatrième colonne, tempsMoyenThreads2" >> tempsMoyenGTOD.dat
#echo "#Cinquième colonne, tempsMoyenThreads3" >> tempsMoyenGTOD.dat
#echo "#Sixième colonne, tempsMoyenThreads4" >> tempsMoyenGTOD.dat


for (( c=1; c<=30; c++))
do 
	tri_seq
	tri_threads1
	tri_threads2
	tri_threads4
	tri_threads8
	tri_threads16
done

tempsMoySeq=$(($tempsTotalSeq/30))
tempsMoyT1=$(($tempsTotalThreads1/30))
tempsMoyT2=$(($tempsTotalThreads2/30))
tempsMoyT4=$(($tempsTotalThreads4/30))
tempsMoyT8=$(($tempsTotalThreads8/30))
tempsMoyT16=$(($tempsTotalThreads16/30))
echo "$taille $tempsMoySeq $tempsMoyT1 $tempsMoyT2 $tempsMoyT4 $tempsMoyT8 $tempsMoyT16" >> tempsMoyenGTOD.dat

exit 0
