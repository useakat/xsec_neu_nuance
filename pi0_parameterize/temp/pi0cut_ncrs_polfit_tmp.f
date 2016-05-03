      real function pi0cut_ncrs_polfit
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi

      cut_flag = 0
c      if ((channel.lt.3).or.(channel.gt.90)) then
c         if (channel.ne.94) cut_flag = 1
c      endif
      missidwgt = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt = 2.22d-7*ppi*(ppi+802d0)
               if (missidwgt.gt.1d0) missidwgt = 1d0
c               if (missidwgt.lt.0d0) missidwgt = 0d0
            endif
         enddo
c      else
c         missidwgt = 0d0
      endif
      pi0cut_ncrs_polfit = missidwgt

      cut_flag = 0
      missidwgt = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt = 2.22d-7*ppi*(ppi+802d0)
c               missidwgt = 2.22d-7*(1.06)*ppi*(ppi+802d0)
c               missidwgt = 2.22d-7*(0.94)*ppi*(ppi+802d0)
               if (missidwgt.gt.1d0) missidwgt = 1d0
            endif
         enddo            
      endif
      pi0cut_ncrs_polfit = missidwgt

 100  return
      end
