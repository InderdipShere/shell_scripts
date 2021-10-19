name="file_name"
stat=0
end=1000
i=0
while [ $i -le 9 ]
do 
  mv name$i.pdb name.00$i
   i=`echo $i+1|bc` 
done
i=10
while [ $i -le 99 ]
do 
  mv name$i.pdb name.0$i
   i=`echo $i+1|bc` 
done
i=100
while [ $i -le 999 ]
do 
  mv name$i.pdb name.$i
   i=`echo $i+1|bc` 
done
i=1000
mv name$i.pdb name.$i
