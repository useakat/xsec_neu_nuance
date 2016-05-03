      real function ccqecut
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      include 'CCQEselectcut.inc'
      if (cut_flag.eq.0) then
         ccqecut = 1
      else
         ccqecut = 0
      endif

      return
      end
