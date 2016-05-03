      real function missidwgt_old_corr2re
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missid_old,ppiG,wgt,missidwgt_old
      external missid_old

      cut_flag = 0
      missidwgt_old_corr2re = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               ppiG = ppi/1d3
               missidwgt_old = missid_old(ppiG)
               if (missidwgt_old.gt.1d0) missidwgt_old = 1d0
               wgt = 0.997982*exp(-0.0366464*ppiG)
     &              +0.624563*exp(-(ppiG -0.7)**2/(2*0.06**2))
     &              -0.357516*exp(-(ppiG -1.29)**2/(2*0.1**2))
     &              -0.112417*exp(-(ppiG -0.5)**2/(2*0.2**2))
c               wgt = 1
               missidwgt_old_corr2re = 1*wgt*missidwgt_old
            endif
         enddo            
      endif

      return
      end

      include 'funcs.inc'
