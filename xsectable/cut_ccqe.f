      real function cut_ccqe
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
c      include 'ccqeselectcut.inc'
      include 'selectcut_ccqe.inc'
      if (cut_flag.eq.0) then
         cut_ccqe = 1
      else
         cut_ccqe = 0
      endif

      return
      end
