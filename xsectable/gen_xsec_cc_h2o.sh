#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    nevent=$3
    output=$4

    log=log.log
    cutlog_h=cut_h.log
    cutlog_o=cut_o.log
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults_cc.cards nuance_defaults2.cards
    cp -rf ../cutnevt* .
    cp -rf ../ccqecut* .
    cp -rf ../../pi0_parameterize/temp/* .
#    cp -rf ../../pi0_parameterize/temp/ne1000.inc .
#    cp -rf ../../pi0_parameterize/temp/selectcut_CCQE.inc .
#    cp -rf ../../pi0_parameterize/temp/ccqeselectcut.inc .
    cp -rf ${HOME}/.pawlogon.kumac .
    mv nuance_defaults2.cards nuance_defaults.cards

    process=CCQE
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent -h ccqeh.hbk ! > $log
    cp -rf ccqeh.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCQEH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCQEO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $log ${log}_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCRS
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent -h ccrsh.hbk ! > $log
    cp -rf ccrsh.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCRSH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCRSO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $log ${log}_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCDI
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent -h ccdih.hbk ! > $log
    cp -rf ccdih.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCDIH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCDIO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $log ${log}_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCCO
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent -h cccoh.hbk ! > $log
    cp -rf cccoh.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCCOH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCCOO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $log ${log}_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCDF
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent -h ccdfh.hbk ! > $log
    cp -rf ccdfh.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCDFH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCDFO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $log ${log}_${process}.log
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

#    nuanceMc.exe -mono $nu $E -t IMB3 -nevt $nevent ! > $log
#    CCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`

    process=CCQE
    nuanceMc.exe -mono $nu $E -t IMB3 -proc $process -nevt $nevent ! > $log
    CCQETOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    CCRSH2=`expr $CCRSH + $CCDIH + $CCCOH + $CCDFH`
    CCRSO2=`expr $CCRSO + $CCDIO + $CCCOO + $CCDFO`
    echo "$EE $CCQEH $CCQEO $CCRSH2 $CCRSO2 $CCQETOT" >> $output

    rm -rf histo.hbk