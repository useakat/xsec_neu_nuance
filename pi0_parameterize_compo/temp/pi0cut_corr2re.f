      real function pi0cut_corr2re
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi0,wgt,ppi0G

      cut_flag = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         pi0cut_corr2re = 1
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi0 = p_hadron(5,i)
               ppi0G = ppi0*0.001
               wgt = 0.997982*exp(-0.0366464*ppi0G)
     &              +0.624563*exp(-(ppi0G -0.7)**2/(2*0.06**2))
     &              -0.357516*exp(-(ppi0G -1.29)**2/(2*0.1**2))
     &              -0.112417*exp(-(ppi0G -0.5)**2/(2*0.2**2))
            endif
         enddo
         pi0cut_corr2re = pi0cut_corr2re*wgt*0.94
      else
         pi0cut_corr2re = 0
      endif

      return
      end
