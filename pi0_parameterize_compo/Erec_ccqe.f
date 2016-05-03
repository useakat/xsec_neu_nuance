      real function Erec_ccqe
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,type
      real p,costh,p2,costh2
      real gran,Erec
      external gran,Erec

      cut_flag = 0
      Erec_ccqe = 0
      include 'selectcut_CCQE.inc'
      if (cut_flag.eq.0) then
         type = abs(lepton(1))
         p = p_lepton(5,1)
         costh = p_lepton(3,1)/p_lepton(5,1)
         call smearing_SK(p,costh,type,p2,costh2)
         Erec_ccqe = Erec(p2,costh2,type)
      endif

 100  return
      end

      include 'funcs.inc'
