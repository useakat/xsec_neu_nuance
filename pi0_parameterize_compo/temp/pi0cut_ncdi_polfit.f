      real function pi0cut_ncdi_polfit
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missidwgt

      cut_flag = 0
      if (channel.ne.92) cut_flag = 1 ! NC DI
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt = 2.22d-7*ppi*(ppi+802d0)
               if (missidwgt.gt.1d0) missidwgt = 1d0
               if (missidwgt.lt.0d0) missidwgt = 0d0
            endif
         enddo            
      else
         missidwgt = 0
      endif
      pi0cut_ncdi_polfit = missidwgt

      return
      end
