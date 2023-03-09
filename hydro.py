#!! Hydrodynamic radius
#!! we consider the van der wall radius of carbon = 1.7A

import re
import sys
import math

a=1.7
coor=open(sys.argv[1],'r')
Natom=int(coor.readline())
coor.readline() # blank

N=0
x=[]
y=[]
z=[]
for i in range(Natom):
	line=coor.readline().split()
	if (line[0] != "H" ) :
		N += 1
		x.append(float(line[1]))
		y.append(float(line[2]))	
		z.append(float(line[3]))
		
rij=0.0
for i in range(N):
	xi= x[i]
	yi= y[i]
	zi= z[i]
	for j in range(i+1,N):	
		rij += 1.0/(pow(pow((x[j]-xi),2)+pow((y[j]-yi),2)+pow((z[j]-zi),2),0.5 ))
	
	
rH  = float(N*a)/ (1.0+ 2*a/float(N)*rij)
print("Hydrodynamic radius", rH)
