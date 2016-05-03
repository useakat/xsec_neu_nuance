      real function NC1pi0cut
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag,npi0
      real mn,mp,Epi,mpl,ppi,costhpi

      cut_flag = 0
      include 'NC1pi0_selectcut.inc'
      if (cut_flag.eq.0) then
         NC1pi0cut = 1
      else
         NC1pi0cut = 0
      endif

      return
      end
