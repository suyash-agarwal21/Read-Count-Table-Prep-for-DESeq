#!/bin/sh

if [ "$1" != "" ]
then 

awk -v treat=$2 '
{
while ( getline line < treat > 0 ){
	split(line,a,"\t");
	if(a[1]!="@SQ"){
		if(a[3]!= "*"){
			id=a[3];
			Id[id]="";
			Treat[id]++;
		}
	}
}
}
{
	if($1!="@SQ"){
		if($3!= "*"){
			id=$3;
			Id[id]="";
			Control[id]++;
		}
	}
}
END{
	print "ID\tControl\tTreated";
	for (id in Id){
		if(Control[id]==""){
			Control[id]=0;
		}
		if(Treat[id]==""){
			Treat[id]=0;
		}
		print id"\t"Control[id]"\t"Treat[id];
	}
}' $1


else

echo "Program: Make_DESeq_RC_Table_from_sam.sh"
echo "Contact: Dr. Suyash Agarwal (suyash.bioinfo@gmail.com)"
echo "Usage: Make_DESeq_RC_Table_from_sam.sh <Control.sam> <Treated.sam>"
fi
