      real function pi0cut
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0

      cut_flag = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         pi0cut = 1
      else
         pi0cut = 0
      endif

      return
      end
