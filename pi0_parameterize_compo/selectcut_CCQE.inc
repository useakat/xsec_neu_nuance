* CCQE selection cut
*
      if (cc.ne.1) cut_flag = 1
      if (n_leptons.ne.1) cut_flag = 1
      if (abs(lepton(1)).eq.12) cut_flag = 1
      if (abs(lepton(1)).eq.14) cut_flag = 1
      if (abs(lepton(1)).eq.15) cut_flag = 1
      if (abs(lepton(1)).eq.16) cut_flag = 1
      if (p_lepton(5,1).lt.200d0) cut_flag = 1	
      do i = 1,n_hadrons
         if (hadron(i).eq.111) cut_flag = 1
         if (hadron(i).eq.130) cut_flag = 1
         if (hadron(i).eq.310) cut_flag = 1
         if (hadron(i).eq.311) cut_flag = 1
         if (abs(hadron(i)).eq.321) cut_flag = 1
      enddo
      do i = 1,n_hadrons
         if (abs(hadron(i)).eq.211) then
            if (p_hadron(5,i).ge.200d0) cut_flag = 1
         endif
      enddo
      do i = 1,n_hadrons
         if (hadron(i).eq.22) then
            if (p_hadron(5,i).ge.30d0) cut_flag = 1
         endif
      enddo
*