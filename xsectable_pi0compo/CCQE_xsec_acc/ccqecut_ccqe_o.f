      real function ccqecut_ccqe_o
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if ((channel.ne.1).and.(channel.ne.95)) cut_flag = 1
      if (bound.ne.1) cut_flag = 1
      include 'ccqeselectcut.inc'
      if (cut_flag.eq.0) then
         ccqecut_ccqe_o = 1
      else
         ccqecut_ccqe_o = 0
      endif

      return
      end
