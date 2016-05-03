      real function ccqe_h
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if ((channel.ne.1).and.(channel.ne.95)) cut_flag = 1
      if (bound.ne.0) cut_flag = 1
      if (cut_flag.eq.0) then
         ccqe_h = 1
      else
         ccqe_h = 0
      endif

      return
      end
