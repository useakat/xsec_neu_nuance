      real function select_ccrs
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if ((channel.lt.3).or.(channel.gt.90)) then
         if (channel.ne.93) cut_flag = 1
      endif
      if (cut_flag.eq.0) then
         select_ccrs = 1
      else
         select_ccrs = 0
      endif

      return
      end
