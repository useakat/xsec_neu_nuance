      real function Erec
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag,npi0
      real mn,mp,Epi,mpl,ppi,costhpi,pmissid
      real random,rndm,mpi0,ppi2,pres,thres
      real theta,theta2,costhpi2
      real gran2
      external gran2

      cut_flag = 0
      Erec = 0
      include 'selectcut_1pi0.inc'
c      if (cut_flag.eq.0) then
      if (cut_flag.eq.0) then
         mn = 939.565346d0
         mp = 938.272013d0
         mpl = 0.511d0
         mpi0 = 134.9766d0

         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               costhpi = p_hadron(3,i)/p_hadron(5,i)
c               ppi = 500
c               costhpi = 0.2
               pres = ppi*(0.6d0 +2.6d0/sqrt(ppi/1d3))/1d2
               thres = 3.0
               ppi2 = ppi +gran2()*pres
c               ppi2 = 1000 +gran2()*100
c               ppi2 = rndm()*1000
c               ppi2 = ppi 
               theta = acos(costhpi)*180/3.141592
               theta2 = theta +gran2()*thres
               costhpi2 = cos(theta2*3.141592/180)

               Epi = sqrt(ppi2**2 +mpi0**2)
               Erec = (mn*Epi -mpl**2/2d0 -(mn**2 -mp**2)/2d0)
     &              /(mn -Epi +ppi2*costhpi2)
c               Epi = sqrt(ppi**2 +mpi0**2)
c               Erec = (mn*Epi -mpl**2/2d0 -(mn**2 -mp**2)/2d0)
c     &              /(mn -Epi +ppi*costhpi)
            endif
         enddo            
      endif

 100  return
      end


      real function gran()
      implicit none
c     const:
      real pi
      parameter(pi=3.14159265358979314d0)
c     local:
      integer odd,iseed,time
      real x1,x2,fac,rndm
c     save:
      save odd,fac,x2
c     begin:
      odd=1-odd
      if (odd.ne.0) then
         x1=rndm()
         x2=rndm()
         fac=sqrt(-2.0*log(x1))
         gran=fac*cos(2.0*pi*x2)
      else
         gran=fac*sin(2.0*pi*x2)
      endif

      return
      end


      real function gran2()
      implicit none
c     local:
      real x1,x2,fac,rndm,r
c     begin:
 100  continue
      x1 = 2.0*rndm() -1.0
      x2 = 2.0*rndm() -1.0
      r = x1**2 +x2**2
      if (r.ge.1.0) then
         goto 100
      endif
      fac = sqrt(-2.0*log(r)/r)
      gran2 = fac*x2

      return
      end
