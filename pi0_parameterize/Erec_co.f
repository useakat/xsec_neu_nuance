      real function Erec_co
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag,npi0
      real mn,mp,Epi,mpl,ppi,costhpi,pmissid
      real random,rndm

      cut_flag = 0
      include 'selectcut.inc'
      if (channel.ne.96) cut_flag = 1
      if (cut_flag.eq.1) then
         Erec_co = 0
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
            
            Erec_co = (mn*Epi -mpl**2/2d0 -(mn**2 -mp**2)/2d0)
     &              /(mn -Epi +ppi*costhpi)
         endif
      enddo            

 100  return
      end
