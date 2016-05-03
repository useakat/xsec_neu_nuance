      real function missidwgt
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi

      cut_flag = 0
      missidwgt = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
c               missidwgt = 2.22d-7*ppi*(ppi+802d0)
c               missidwgt = 2.22d-7*(1.13)*ppi*(ppi+802d0)
               missidwgt = 2.22d-7*(0.87)*ppi*(ppi+802d0)
               if (missidwgt.gt.1d0) missidwgt = 1d0
            endif
         enddo            
      endif

 100  return
      end
