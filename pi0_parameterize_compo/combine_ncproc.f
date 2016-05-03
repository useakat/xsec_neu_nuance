      program combine_ncproc
      implicitnone
      integer i,nlines,nmax
      parameter (nmax = 1000)
      real*8 x(nmax),qe(nmax),rs(nmax),co(nmax),di(nmax),tot(nmax)

      open(1,file="ncqe.dat",status="old")
      i = 1
      do
         read(1,*,end=99) x(i),qe(i)
         i = i+1
      enddo
 99   close(1)
      open(1,file="ncrs.dat",status="old")
      i = 1
      do
         read(1,*,end=100) x(i),rs(i)
         i = i+1
      enddo
 100  close(1)
      open(1,file="ncco.dat",status="old")
      i = 1
      do
         read(1,*,end=101) x(i),co(i)
         i = i+1
      enddo
 101  close(1)
      open(1,file="ncdi.dat",status="old")
      i = 1
      do
         read(1,*,end=102) x(i),di(i)
         i = i+1
      enddo
 102  close(1)
      open(1,file="total.dat",status="old")
      i = 1
      do
         read(1,*,end=103) x(i),tot(i)
         i = i+1
      enddo
 103  close(1)
      nlines = i-1

      open(1,file="tmp.inc",status="replace")
      write(1,*) "     real*8 ARRAY(",nlines,",6)"
      do i = 1,nlines
         write(1,200) "      data (ARRAY(",i,",oi),oi=1,6) /", 
     &        x(i),",",qe(i),",",rs(i),",",co(i),",",di(i),","
     &        ,tot(i)," /"
      enddo
      close(1)

 200  format(a18,i3,a14,f10.5,5(a1,f10.7),a2)

      end
