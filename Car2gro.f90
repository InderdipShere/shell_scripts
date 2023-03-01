! PROGRAM CONVERTS THE CAR FILE FORMAT TO GROMACS GRO 
PROGRAM CAR2GRO
  IMPLICIT NONE
  REAL*8:: X,Y, Z, CHARG, LX,LY,LZ, ALPHA,BETA,GAMMA, &
          AX,BX,BY,CX,CY,CZ, D2R
  INTEGER:: I, J, K, NATOM, NMOF, NTYPE, PX,PY,PZ, PN,&
                         NFLUID, NFLUID_TYPE, PNFLUID
  INTEGER, ALLOCATABLE:: N_NTYPE(:), N_NFLUID_TYPE(:)
  CHARACTER*50:: LAB, GROFILE, GROFORMAT, CARFILE, LAB2, MOF, FLUID 
 
 GROFORMAT='(i5,2a5,i5,3f8.3,3f8.4)'
 D2R=DACOS(-1.0D0)/180.0D0
 PRINT*, "DEG2RAD CONV FACT ", D2R
 OPEN(21,FILE="input_CAR2GRO.dat", STATUS='OLD')
   READ(21,*) MOF
   READ(21,*) NTYPE    
   ALLOCATE(N_NTYPE(NTYPE))
   DO I = 1, NTYPE
     READ(21,*) N_NTYPE(I)
   END DO 
   NMOF = SUM(N_NTYPE)
   READ(21,*) PX,PY,PZ
   READ(21,*) CARFILE
   READ(21,*) GROFILE
   READ(21,*) !BLANK
   READ(21,*) FLUID 
   READ(21,*) NFLUID_TYPE
   ALLOCATE(N_NFLUID_TYPE(NFLUID_TYPE))

   DO I = 1, NFLUID_TYPE
 	   READ(21,*) N_NFLUID_TYPE(I)
   END DO  
   NFLUID =  SUM(N_NFLUID_TYPE)
   READ(21,*) PNFLUID
 CLOSE(21)
 PN = PX*PY*PZ 
 NATOM =  PN*NMOF +  PNFLUID*NFLUID
 PRINT*, "                         ",TRIM(MOF),"          ", TRIM(FLUID)
 PRINT*, "NO OF MOLECULES        : ",       PN, PNFLUID
 PRINT*, "NO OF ATOM PER MOLECULE: ",     NMOF, NFLUID 
 PRINT*, "TOTAL NO OF ATOMS      : ",  PN*NMOF, PNFLUID*NFLUID 
 PRINT*, "TOTAL ATOMS IN SYSTEM  : ",    NATOM
 OPEN(22,FILE=TRIM(CARFILE), STATUS='OLD')

 OPEN(31,FILE=TRIM(GROFILE))
 OPEN(32,FILE="New_index.ndx")
 WRITE(31,*) PNFLUID+1, "TOTAL MOLECULES"
 DO I = 1, 4
 	READ(22,*) !
 END DO 
 WRITE(32,*) "[ ",TRIM(MOF)," ]"
 
 READ(22,*) LAB, LX,LY,LZ, ALPHA, BETA, GAMMA 
 WRITE(31,*) NATOM 
 DO J = 1, PN
   DO I = 1, NMOF 
     READ(22,*) LAB2, X,Y, Z , LAB, K, LAB, LAB, CHARG
     WRITE(31,GROFORMAT) 1, TRIM(ADJUSTL(MOF)), TRIM(ADJUSTL(LAB)), (J-1)*NMOF+I, X/10.0, Y/10.0, Z/10.0   
     WRITE(32,*) (J-1)*NMOF+I
   END DO 
 END DO 
 READ(22,*) ! end
 WRITE(32,*) !
 WRITE(32,*) "[ ",TRIM(FLUID)," ]"
 DO J = 1, PNFLUID
   DO I = 1, NFLUID
     READ(22,*) LAB2, X,Y, Z , LAB, K, LAB, LAB, CHARG
     WRITE(31,GROFORMAT) 1+J, TRIM(ADJUSTL(FLUID)), TRIM(ADJUSTL(LAB)), PN*NMOF+(J-1)*NFLUID +I, X/10, Y/10, Z/10        
     WRITE(32,*)  PN*NMOF+(J-1)*NFLUID +I
   END DO 
 END DO 
 LX= LX/10.0D0 ! nm
 LY= LY/10.0D0
 LZ= LZ/10.0D0
 ALPHA=ALPHA*D2R
 BETA =BETA *D2R
 GAMMA=GAMMA*D2R
 AX=LX
 BX=LY*DCOS(GAMMA) ; BY=LY*DSIN(GAMMA)
 CX=LZ*DCOS(BETA)  ; CY=(LY*LZ*DCOS(ALPHA)-BX*CX)/BY
 CZ=DSQRT(LZ*LZ -CX*CX- CY*CY)

 WRITE(31,*) AX,BY,CZ, 0.0, 0.0, BX, 0.0, CX,CY !, ALPHA, BETA, GAMMA
 CLOSE(31)

END PROGRAM CAR2GRO