#rusage
#tri_seq
tempsRUserSeq=0
tempsRSysSeq=0

#tri_threads 1
tempsRUserThreads1=0
tempsRSysThreads1=0

#tri_threads 2
tempsRUserThreads2=0
tempsRSysThreads2=0

#tri_threads 4
tempsRUserThreads4=0
tempsRSysThreads4=0

#tri_threads 8
tempsRUserThreads8=0
tempsRSysThreads8=0

#tri_threads 16
tempsRUserThreads16=0
tempsRSysThreads16=0


tri_seq(){
	res=$(echo $taille | ./tri_sequentiel  --quiet --time --rusage)
	tUser=$(echo $res | cut -d, -f2)
	tempsRUserSeq=$(($tUser + $tempsRUserSeq))
	tSys=$(echo $res | cut -d, -f3)
	tempsRSysSeq=$(($tSys + $tempsRSysSeq))
}

tri_threads1(){
	res=$(echo $taille | ./tri_threads --parallelism 1 --quiet --time --rusage)
	tUser1=$(echo $res | cut -d, -f2)
	tempsRUserThreads1=$(($tUser1 + $tempsRUserThreads1))
	tSys1=$(echo $res | cut -d, -f3)
	tempsRSysThreads1=$(($tSys1 + $tempsRSysThreads1))
}

tri_threads2(){
	res=$(echo $taille | ./tri_threads --parallelism 2 --quiet --time --rusage)
	tUser2=$(echo $res | cut -d, -f2)
	tempsRUserThreads2=$(($tUser2 + $tempsRUserThreads2))
	tSys2=$(echo $res | cut -d, -f3)
	tempsRSysThreads2=$(($tSys2 + $tempsRSysThreads2))
}

tri_threads4(){
	res=$(echo $taille | ./tri_threads --parallelism 4 --quiet --time --rusage)
	tUser4=$(echo $res | cut -d, -f2)
	tempsRUserThreads4=$(($tUser4 + $tempsRUserThreads4))
	tSys4=$(echo $res | cut -d, -f3)
	tempsRSysThreads4=$(($tSys4 + $tempsRSysThreads4))
}

tri_threads8(){
	res=$(echo $taille | ./tri_threads --parallelism 8 --quiet --time --rusage)
	tUser8=$(echo $res | cut -d, -f2)
	tempsRUserThreads8=$(($tUser8 + $tempsRUserThreads8))
	tSys8=$(echo $res | cut -d, -f3)
	tempsRSysThreads8=$(($tSys8 + $tempsRSysThreads8))
}

tri_threads16(){
	res=$(echo $taille | ./tri_threads --parallelism 16 --quiet --time --rusage)
	tUser16=$(echo $res | cut -d, -f2)
	tempsRUserThreads16=$(($tUser16 + $tempsRUserThreads16))
	tSys16=$(echo $res | cut -d, -f3)
	tempsRSysThreads16=$(($tSys16 + $tempsRSysThreads16))
}

echo -n "taille du vecteur ?"
read taille;

for (( c=1; c<=30; c++))
do 
	tri_seq
	tri_threads1
	tri_threads2
	tri_threads4
	tri_threads8
	tri_threads16
done

tempsRUserSeqMoy=$(($tempsRUserSeq/30))
tempsRUserThreads1Moy=$(($tempsRUserThreads1/30))
tempsRUserThreads2Moy=$(($tempsRUserThreads2/30))
tempsRUserThreads4Moy=$(($tempsRUserThreads4/30))
tempsRUserThreads8Moy=$(($tempsRUserThreads8/30))
tempsRUserThreads16Moy=$(($tempsRUserThreads16/30))
echo "$taille $tempsRUserSeq $tempsRUserThreads1Moy $tempsRUserThreads2Moy $tempsRUserThreads4Moy $tempsRUserThreads8Moy $tempsRUserThreads16Moy" >> tempsMoyenGRU.dat

exit 0