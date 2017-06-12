#!/bin/bash

N=0 #numerator
D=1 #denominator
P=5 #precision
is_number_valid()
{
	num=$1
re='^[-+]?[0-9]+\.?[0-9]*$'

if [[ "$num" =~ $re ]]; then
    echo "Entered number is ok"
else 
    echo "It is not a number!";
    exit
fi
}

read -p "Enter a numerator: > " N
is_number_valid $N

read -p "Enter a denominator: > " D
is_number_valid $D

read -p "Enter precision: > " P

#splited into quoitent and reainder numerator
N_S=($(echo $N | tr "." "\n"))
#splited into quoitent and reainder denominator
D_S=($(echo $D | tr "." "\n"))

N_ZAP=0 #quantity of numerator`s zeroes after point
D_ZAP=0 #quantity of denominator`s zeroes after point



foo=${N_S[1]}
for (( i=0; i<${#foo}; i++ )); do
  if [[ ${foo:$i:1}!=0 ]]; then
  	break
  fi
  echo "${foo:$i:1}"
  N_ZAP=$((N_ZAP+1))
done

foo=${D_S[1]}
for (( i=0; i<${#foo}; i++ )); do
  if [[ ${foo:$i:1}!=0 ]]; then
  	break
  fi
  D_ZAP=$((D_ZAP+1))
done

zero="0"

len=${#N_S[1]}
while [[ "$len" -lt "$P" ]]; do
	N_S[1]="${N_S[1]}$zero"
	len=${#N_S[1]}
done


len=${#D_S[1]}
while [[ "$len" -lt "$P" ]]; do
	D_S[1]="${D_S[1]}$zero"
	len=${#D_S[1]}
done

sub() 
{
	n_pre=$1
	n_su=$2
	d_pre=$3
	d_su=$4
	if [[ "$d_su" > "$n_su" ]]; then
		n_pre=$((n_pre-1))
    	n_su=$((n_su+100000))
	fi
  n_su=$((n_su-d_su));
  n_pre=$((n_pre-d_pre));
}

increase()
{
	n_pre=$1
	n_su=$2
	n_zap=$3

    n_pre=$((n_pre*10))
    n_su=$((n_su*10))
    
    if [[ n_zap -eq 0 ]]; then
	   n_pre=$((n_pre+n_su/100000))
       n_su=$((n_su%100000))
    else
	   n_zap=$((n_zap-1))
    fi
}

ge()
{
	n_pre=$1
	n_su=$2
	d_pre=$3
	d_su=$4
	if [[ "$n_pre" -gt "$d_pre" ]]; then
		greq=1
	elif [[ "$n_pre" -eq "$d_pre" ]]; then
		if [[ "$n_su" -ge "$d_su" ]]; then
		 	greq=1
		 else
		 	greq=0
		 fi
	else
		greq=0

	fi
}

division() 
{
	n_pre=$1
	n_su=$2
	n_zap=$3
	d_pre=$4
	d_su=$5
	d_zap=$6
rez_pre=0
rez_su=0
#rez_zap=0
ecz=$P 
ge $n_pre $n_su $d_pre $d_su

while [[ greq -ne 0 ]]; do
	sub $n_pre $n_su $d_pre $d_su
    rez_pre=$((rez_pre+1))
	ge $n_pre $n_su $d_pre $d_su

done
while [[ ecz -ne 0 ]]; do
	times=0
    increase $n_pre $n_su $n_zap
    ge $n_pre $n_su $d_pre $d_su
	while [[ greq -ne 0 ]]; do
      sub $n_pre $n_su $d_pre $d_su
      ge $n_pre $n_su $d_pre $d_su
      times=$((times+1))
    done
    rez_su=$((rez_su+times))
    rez_su=$((rez_su*10))
    ecz=$((ecz-1))
done

  rez_su=$((rez_su/10))
}

division  ${N_S[0]} ${N_S[1]} $N_ZAP ${D_S[0]} ${D_S[1]} $D_ZAP

echo $rez_pre.$rez_su

#for part in $N_S
#do
#    echo "$part"
#done