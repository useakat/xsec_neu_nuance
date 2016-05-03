      program combine_1pi0bg_eachEv
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Oct.26 2013
C     ****************************************************
      implicitnone
C     CONSTANTS     
C     ARGUMENTS 
C     GLOBAL VARIABLES
C     LOCAL VARIABLES 
      character*2 cnu
      character*5 cEnu5,cmares5
      character*6 cEnu6,cmares6
      integer i,j
      integer nfiles,nlines
      real*8 Enu,Enumin,dEnu,mares,x,y
      real*8 events(1000,0:100)
C     EXTERNAL FUNCTIONS
C     ----------
C     BEGIN CODE
C     ----------
      open(1,file="setting.dat",status="old")
      read(1,*) cnu,mares,Enumin,dEnu,nfiles
      close(1)

      do j = 1,nfiles
         Enu = Enumin +dEnu*(j-1)
         if (Enu.lt.1000) then
            write(cEnu5,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               open(1,file="1pi0bg_table/"//cnu//cEnu5(3:5)//"."
     &              //cmares5(3:5)//".dat",status="old")
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               open(1,file="1pi0bg_table/"//cnu//cEnu5(3:5)//"."
     &              //cmares6(3:6)//".dat",status="old")
            endif
         elseif (Enu.lt.10000) then
            write(cEnu6,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               open(1,file="1pi0bg_table/"//cnu//cEnu6(3:6)//"."
     &              //cmares5(3:5)//".dat",status="old")
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               open(1,file="1pi0bg_table/"//cnu//cEnu6(3:6)//"."
     &              //cmares6(3:6)//".dat",status="old")
            endif
         endif
         i = 1
         do
            read(1,*,end=99) x,y
            if (j.eq.1) then
               events(i,0) = x
            endif
            events(i,j) = y
            i = i+1
         enddo
C
C     write down the output file
C
         if (Enu.lt.1000) then
            write(cEnu5,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               open(2,file="pi0bg_"//cnu//"_ma"//cmares5(3:5)//"_E"
     &              //cEnu5(3:5)//".inc",status="replace")
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               open(2,file="pi0bg_"//cnu//"_ma"//cmares6(3:6)//"_E"
     &              //cEnu5(3:5)//".inc",status="replace")
            endif
         elseif (Enu.lt.10000) then
            write(cEnu6,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               open(2,file="pi0bg_"//cnu//"_ma"//cmares5(3:5)//"_E"
     &              //cEnu6(3:6)//".inc",status="replace")
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               open(2,file="pi0bg_"//cnu//"_ma"//cmares6(3:6)//"_E"
     &              //cEnu6(3:6)//".inc",status="replace")
            endif
         endif

         write(2,*) 
     &        "C/*----------------------------------------------------"
         write(2,*) 
     &        "C// 1pi0-bg Erec distribution  table"
         write(2,*) 
     &        "C// Erec(GeV), Events"
         write(2,*) 
     &        "C/-----------------------------------------------------*"
         if (Enu.lt.1000) then
            write(cEnu5,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               write(2,*) "     real*8 pi0bg_"//cnu//"_ma"//cmares5(3:5)
     &              "_E"//cEnu5(3:5)//"(0:NLINES,2)"
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               write(2,*) "     real*8 pi0bg_"//cnu//"_ma"//cmares6(3:6)
     &              "_E"//cEnu5(3:5)//"(0:NLINES,NFILES)"
            endif
         elseif (Enu.lt.10000) then
            write(cEnu6,*) Enu
            if (mares.lt.1000) then
               write(cmares5,*) mares
               write(2,*) "     real*8 pi0bg_"//cnu//"_ma"//cmares5(3:5)
     &              "_E"//cEnu6(3:6)//"(0:NLINES,2)"
            elseif (mares.lt.10000) then
               write(cmares6,*) mares
               write(2,*) "     real*8 pi0bg_"//cnu//"_ma"//cmares6(3:6)
     &              "_E"//cEnu6(3:6)//"(0:NLINES,NFILES)"
            endif
         endif
         close(2)
C         
 99      close(1)
      enddo
      nlines = i -1

      open(1,file="nlines.dat",status="replace")
      write(1,*) nlines,nfiles
      close(1)

 100  format(a13,1x,i1,a5,1x,f7.5,1000(',',1x,f7.5))
 200  format(a13,1x,i2,a5,1x,f7.5,1000(',',1x,f7.5))
 300  format(a13,1x,i3,a5,1x,f7.5,1000(',',1x,f7.5))
 400  format(a13,1x,i1,a5,1x,a2,1000(',',1x,f3.1))

      end
