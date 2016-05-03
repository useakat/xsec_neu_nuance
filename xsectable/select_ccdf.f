      real function select_ccdf
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if (channel.ne.97) cut_flag = 1
      if (target.eq.2212) cut_flag = 1
      if (cut_flag.eq.0) then
         select_ccdf = 1
      else
         select_ccdf = 0
      endif

      return
      end
