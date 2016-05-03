      real function missidwgt
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi
      real missid_polfit
      external missid_polfit

      cut_flag = 0
      missidwgt = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt = missid_polfit(ppi)
               if (missidwgt.gt.1d0) missidwgt = 1d0
            endif
         enddo            
      endif

 100  return
      end

      include 'funcs.inc'
