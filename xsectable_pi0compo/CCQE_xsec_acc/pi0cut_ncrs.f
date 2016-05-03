      real function pi0cut_ncrs
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0

      cut_flag = 0
      if ((channel.lt.3).or.(channel.gt.90)) cut_flag = 1
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         pi0cut_ncrs = 1
      else
         pi0cut_ncrs = 0
      endif

      return
      end
