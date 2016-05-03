#! /bin/bash
    paw -b $kumac_h > $log_h 
    paw -b $kumac_o > $log_o 
    paw -b $kumac_cut_h > $cutlog_h # CCQE cut
    paw -b $kumac_cut_o > $cutlog_o # CCQE cut
    Hpre=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $log_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    Opre=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $log_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    H=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    O=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    if [ $Hpre -ne 0 ]; then
	Hacc=`echo "scale=5; ${H}/${Hpre}" | bc | sed 's/^\./0./'`
    else
	Hacc=0
    fi
    if [ $Opre -ne 0 ]; then
	Oacc=`echo "scale=5; ${O}/${Opre}" | bc | sed 's/^\./0./'`
    else
	Oacc=0
    fi
    mv $log_h log_h_${process}.log
    mv $log_o log_o_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log
    echo "${process}(O)" $Opre $O $Oacc >> $output
    echo "${process}(p)" $Hpre $H $Hacc >> $output