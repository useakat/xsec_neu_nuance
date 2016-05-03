      real function Erec_ccqe_nosmear
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      Erec_ccqe_nosmear = 0
      mn = 939.565346d0
      mp = 938.272013d0

      include 'selectcut_CCQE.inc'
      if (cut_flag.eq.0) then
         Epi = p_lepton(4,1)
         ppi = p_lepton(5,1)
         costhpi = p_lepton(3,1)/p_lepton(5,1)
         
         if (abs(lepton(1)).eq.11) then
            mpl = 0.510998928d0
         elseif (abs(lepton(1)).eq.13) then
            mpl = 105.6583715d0
         endif
c         Epi = sqrt(ppi**2 +mpl**2)
         
         Erec_ccqe_nosmear = (mn*Epi -mpl**2/2d0 -(mn**2 -mp**2)/2d0)
     &        /(mn -Epi +ppi*costhpi)
      endif

 100  return
      end
