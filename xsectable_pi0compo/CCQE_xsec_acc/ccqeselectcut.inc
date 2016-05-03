      if (cc.ne.1) cut_flag = 1
      if (n_leptons.ne.1) cut_flag = 1
      if (abs(lepton(1)).ne.11) then
         if (abs(lepton(1)).ne.13) cut_flag = 1
      endif			   
      if (p_lepton(5,1).lt.200d0) cut_flag = 1
      do i = 1,n_hadrons
         if (hadron(i).eq.111) cut_flag = 1
         if (hadron(i).eq.130) cut_flag = 1
         if (hadron(i).eq.310) cut_flag = 1
         if (hadron(i).eq.311) cut_flag = 1
         if (abs(hadron(i)).eq.321) cut_flag = 1
         if (abs(hadron(i)).eq.211) then
            if (p_hadron(5,i).gt.200d0) cut_flag = 1
         elseif (hadron(i).eq.22) then
            if (p_hadron(5,i).gt.30d0) cut_flag = 1
         endif
      enddo
