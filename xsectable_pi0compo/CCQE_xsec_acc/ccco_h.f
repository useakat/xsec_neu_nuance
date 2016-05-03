      real function ccco_h
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if (channel.ne.97) cut_flag = 1
      if (target.ne.2212) cut_flag = 1
      if (cut_flag.eq.0) then
         ccco_h = 1
      else
         ccco_h = 0
      endif

      return
      end
