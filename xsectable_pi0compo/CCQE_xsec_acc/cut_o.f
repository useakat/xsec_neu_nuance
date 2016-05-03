      real function cut_o
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if (bound.eq.0) cut_flag = 1
      if (cut_flag.eq.0) then
         cut_o = 1
      else
         cut_o = 0
      endif

      return
      end
