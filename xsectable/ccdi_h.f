      real function ccdi_h
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      if (channel.ne.91) cut_flag = 1
      if (bound.ne.0) cut_flag = 1
      if (cut_flag.eq.0) then
         ccdi_h = 1
      else
         ccdi_h = 0
      endif

      return
      end
