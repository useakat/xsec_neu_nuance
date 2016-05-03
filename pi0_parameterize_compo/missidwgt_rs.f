      real function missidwgt_rs
      implicit none
      include 'ne1000.inc'
      integer pi0_flag,i,cut_flag,npi0
      real mn,mp,Epi,mpl,ppi,costhpi,pmissid
      real random,rndm

      cut_flag = 0
      missidwgt_rs = 0
      include 'selectcut.inc'
      if ((channel.lt.3).or.(channel.gt.90)) cut_flag = 1
      if (cut_flag.eq.0) then
         do i = 1,n_hadrons
            if (hadron(i).eq.111) then
               ppi = p_hadron(5,i)
               missidwgt_rs = 2.22d-7*ppi*(ppi+802d0)
            endif
         enddo            
      endif

 100  return
      end
