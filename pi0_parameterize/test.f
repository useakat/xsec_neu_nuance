      program test
      implicitnone
      integer i
      real missid_old,ppi
      external missid_old

      open(1,file="missid_old_test.dat",status="unknown")
      do i = 1,1000
         ppi = 2/1d3*i
         write(1,*) ppi,missid_old(ppi)
      enddo
      close(1)
      
      end

      real function missid_old(ppi)
      implicit none
      real ppi
      
      missid_old = 0d0
      if (ppi.lt.0.1d0) then
         missid_old = 0d0
      elseif (ppi.lt.0.905d0) then
         missid_old = 0.387d0 -1.13*exp(-11.3*ppi)
      elseif (ppi.lt.1.13d0) then
         missid_old = 1.65*ppi -1.1d0
      elseif (ppi.ge.1.13d0) then
         missid_old = 6.79*(1d0 -exp(-ppi/0.32d0)) -5.83d0
      endif

      return
      end
