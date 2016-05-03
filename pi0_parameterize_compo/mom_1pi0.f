      real function mom_1pi0
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0
      real ppi

      cut_flag = 0
      mom_1pi0 = 0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               mom_1pi0 = p_hadron(5,i)
            endif
         enddo            
      endif

 100  return
      end
