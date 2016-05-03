      real function pi0cut_invpolwgt_ncrs
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real wgt
      cut_flag = 0
      wgt = 0d0
      if ((channel.lt.3).or.(channel.gt.90)) then
         if (channel.ne.94) cut_flag = 1
      endif
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               wgt = 1 -2.22d-7*ppi*(ppi+802d0)
               if (wgt.lt.0d0) wgt = 0d0
            endif
         enddo            
      else
         wgt = 0d0
      endif
      pi0cut_invpolwgt_ncrs = wgt

      return
      end
