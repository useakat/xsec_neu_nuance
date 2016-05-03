      real function pi0cut_ncrs_polfit
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi,missidwgt
c     real polfitwgt
c      external polfitwgt

      cut_flag = 0
      if ((channel.lt.3).or.(channel.gt.90)) then ! CC & NC 1pi0
         if (channel.ne.94) cut_flag = 1 ! gamma production
      endif
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
c         pi0cut_ncrs_polfit = polfitwgt()
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
c               missidwgt = 2.22d-7*ppi*(ppi+802d0)
               missidwgt = 2.22d-7*(1.11)*ppi*(ppi+802d0)
               if (missidwgt.gt.1d0) missidwgt = 1d0
               if (missidwgt.lt.0d0) missidwgt = 0d0
            endif
         enddo            
      else
         missidwgt = 0
c         pi0cut_ncrs_polfit = 0
      endif
      pi0cut_ncrs_polfit = missidwgt

      return
      end

c      include 'funcs.inc'
