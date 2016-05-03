      real function missid_polfit(ppi)
      implicit none
      real ppi
      missid_polfit = 2.22d-7*(1.0)*ppi*(ppi+802d0*(1.19))
      return
      end

      real function missid_old(ppi)
      implicit none
      real ppi
      missid_old = 0d0
      if (ppi.lt.0.1d0) then
         missid_old = 0d0
      elseif (ppi.lt.0.905d0) then
         missid_old = 0.387d0 -1.13*exp(-11.3*ppi)
      elseif (ppi.lt.1.13d0) then
         missid_old = 1.65*ppi -1.1d0
      elseif (ppi.ge.1.13d0) then
         missid_old = 6.79*(1d0 -exp(-ppi/0.32d0)) -5.83d0
      endif
      return
      end

      real function Erec(p,costh,type)
      implicit none
      integer type
      real p,costh
      real mn,mp,ml,me,mmu,E
      mn = 939.565346d0
      mp = 938.272013d0
      me = 0.510998928d0
      mmu = 105.6583715d0
      if (type.eq.11) ml = me 
      if (type.eq.13) ml = mmu
      E = sqrt(p**2 +ml**2)
      Erec = (mn*E -ml**2/2d0 -(mn**2 -mp**2)/2d0)
     &     /(mn -E +p*costh)
      return
      end


      real function gran()
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
      gran = fac*x2

      return
      end


      subroutine smearing_SK(p,costh,type,p2,costh2)
c     This subroutine returns smeared momentum and costh
c     of the lepton detected by SK detector.
c
c     p: lepton momentum in Lab frame in MeV
c     costh: lepton costh in Lab frame w.r.t incoming neutrino
c            direction
c     Yoshitaro Takaesu 2013/Oct/26 @KIAS
      implicit none
      integer type
      real p,costh,p2,costh2
      real pres,thres,theta,theta2
      real gran
      external gran

      if (type.eq.11) then
         pres = p*(0.6d0 +2.6d0/sqrt(p/1d3))/1d2
         thres = 3.0
      elseif (type.eq.13) then
         pres = p*(1.7d0 +0.7d0/sqrt(p/1d3))/1d2
         thres = 1.8
      endif
      p2 = p +gran()*pres
      theta = acos(costh)*180/3.141592
      theta2 = theta +gran()*thres
      costh2 = cos(theta2*3.141592/180)      
      
      return
      end
