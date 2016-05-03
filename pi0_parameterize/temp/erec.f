      real function erec
      implicit none
      include 'ne1000.inc'
      integer i
      integer cut_flag,npi0,type
      real ppi,costhpi,ppi2,costhpi2
      real gran,Erec
      external gran,Erec

      cut_flag = 0
      erec = 0d0
      include 'selectcut_1pi0.inc'
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
           if (hadron(i).eq.111) then
               type = 11
               ppi = p_hadron(5,i)
               costhpi = p_hadron(3,i)/p_hadron(5,i)
               call smearing_SK(ppi,costhpi,type,ppi2,costhpi2)
               erec_1pi0 = Erec(ppi2,costhpi2,type)
            endif
         enddo            
      endif

 100  return
      end

      include 'funcs.inc'
