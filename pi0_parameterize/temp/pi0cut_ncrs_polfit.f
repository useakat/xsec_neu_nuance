      real function pi0cut_ncrs_polfit
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missidwgt
      real missid_polfit
      external missid_polfit

      cut_flag = 0
      if ((channel.lt.3).or.(channel.gt.90)) then ! CC & NC 1pi0
         if (channel.ne.94) cut_flag = 1 ! gamma production
      endif
      include 'selectcut_1pi0.inc' ! NC1pi0 cut
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
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
      pi0cut_ncrs_polfit = missidwgt

      return
      end

      include 'funcs.inc'
