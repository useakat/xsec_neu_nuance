      real function polfitwgt(dum)
      implicit none
      include 'ne1000.inc'
      integer i
      real ppi,missidwgt,dum

      polfitwgt = 0
      do i =1,n_hadrons
         if (hadron(i).eq.111) then
            ppi = p_hadron(5,i)
            polfitwgt = 2.22d-7*ppi*(ppi+802d0)
            if (polfitwgt.gt.1d0) polfitwgt = 1d0
            if (polfitwgt.lt.0d0) polfitwgt = 0d0
         endif
      endif
      
      return
      end
