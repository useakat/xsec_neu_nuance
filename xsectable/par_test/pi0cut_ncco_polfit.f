      real function pi0cut_ncco_polfit
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missidwgt
      real missid_polfit
      external missid_polfit

      cut_flag = 0
      if (channel.ne.96) then ! NC coh/diff pi
         cut_flag = 1
      endif
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i =1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt = missid_polfit(ppi)
               if (missidwgt.gt.1d0) missidwgt = 1d0
               if (missidwgt.lt.0d0) missidwgt = 0d0
            endif
         enddo
      else
         missidwgt = 0
      endif
      pi0cut_ncco_polfit = missidwgt

      return
      end

      include 'funcs.inc'
