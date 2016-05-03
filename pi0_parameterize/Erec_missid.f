      real function Erec_missid
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag,npi0
      real mn,mp,Epi,mpl,ppi,costhpi,pmissid
      real random,rndm

      cut_flag = 0
      include 'selectcut.inc'
      if (cut_flag.eq.1) then
         Erec_missid = -1
         goto 100
      endif

      mn = 939.565346d0
      mp = 938.272013d0
      mpl = 0.511d0
      
      do i = 1,n_hadrons
         if (hadron(i).eq.111) then
            Epi = p_hadron(4,i)
            ppi = p_hadron(5,i)
            costhpi = p_hadron(3,i)/p_hadron(5,i)
            
            pmissid = 2.22d-7*ppi*(ppi+802d0)
            random = rndm()
            if (random.le.pmissid) then
               Erec_missid = (mn*Epi -mpl**2/2d0 -(mn**2 -mp**2)/2d0)
     &              /(mn -Epi +ppi*costhpi)
            else
               Erec_missid = -1d0
            endif
            goto 100
         endif
      enddo            

 100  return
      end
