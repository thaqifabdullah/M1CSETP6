#!/bin/bash

#Justifier que les utilisateur et l'ordonnanceur ont une influence sur le programme

tri_seq(){
	res=$(echo $taille | ./tri_sequentiel  --quiet --time --rusage)
	temps=$(echo $res | cut -d, -f1)
	echo "$taille $temps" >> question2.dat 
}

echo -n "taille du vecteur ?"
read taille;

for (( c=1; c<=5; c++))
do 
	tri_seq
done