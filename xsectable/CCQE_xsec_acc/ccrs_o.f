      real function ccrs_o
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if ((channel.lt.3).or.(channel.gt.90)) then
         if (channel.ne.93) cut_flag = 1
      endif
      if (bound.ne.1) cut_flag = 1
      if (cut_flag.eq.0) then
         ccrs_o = 1
      else
         ccrs_o = 0
      endif

      return
      end
