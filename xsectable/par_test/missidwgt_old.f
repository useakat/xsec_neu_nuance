      real function missidwgt_old
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missid_old,ppiG
      external missid_old

      cut_flag = 0
      missidwgt_old = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               ppiG = ppi/1d3
               missidwgt_old = missid_old(ppiG)
               if (missidwgt_old.gt.1d0) missidwgt_old = 1d0
            endif
         enddo            
      endif

      return
      end

      include 'funcs.inc'
