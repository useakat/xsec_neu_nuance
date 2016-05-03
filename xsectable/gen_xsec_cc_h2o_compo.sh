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
    cp -rf ../select_* .
    cp -rf ../../pi0_parameterize/temp/* .
    cp -rf ${HOME}/.pawlogon.kumac .
    mv nuance_defaults2.cards nuance_defaults.cards

    nuanceMc.exe -mono $nu $E -t IMB3 -nevt $nevent -h histo.hbk ! > $log
    paw -b select_ccqe.kumac > ccqe.log # Take only CCQE mode events
    # paw -b select_ccrs.kumac > ccrs.log # CCRS mode
    # paw -b select_ccdi.kumac > ccdi.log # CCDI mode
    # paw -b select_ccco.kumac > ccco.log # CCCO mode
    # paw -b select_ccdf.kumac > ccdf.log # CCDF mode
    CCQETOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' ccqe.log | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    # CCRSTOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' ccrs.log | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    # CCDITOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' ccdi.log | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    # CCCOTOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' ccco.log | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    # CCDFTOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' ccdf.log | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    process=CCQE
#    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b ccqecut_ccqe_h.kumac > $cutlog_h # Take CCQE-H mode events after the CCQE cut
    paw -b ccqecut_ccqe_o.kumac > $cutlog_o # Take CCQE-O mode events after the CCQE cut
    CCQEH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCQEO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCRS
    paw -b ccqecut_ccrs_h.kumac > $cutlog_h
    paw -b ccqecut_ccrs_o.kumac > $cutlog_o
    CCRSH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCRSO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCDI
    paw -b ccqecut_ccdi_h.kumac > $cutlog_h
    paw -b ccqecut_ccdi_o.kumac > $cutlog_o
    CCDIH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCDIO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    process=CCCO

    paw -b ccqecut_ccco_h.kumac > $cutlog_h # corresponding to CCDF NUANCE process
    paw -b ccqecut_ccco_o.kumac > $cutlog_o # corresponding to CCCO NUANCE process
    CCCOH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCCOO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    mv $cutlog_h cutlog_h_${process}.log
    mv $cutlog_o cutlog_o_${process}.log

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    CCRSH2=`expr $CCRSH + $CCDIH + $CCCOH`
    CCRSO2=`expr $CCRSO + $CCDIO + $CCCOO`
    echo "$EE $CCQEH $CCQEO $CCRSH2 $CCRSO2 $CCQETOT" >> $output

    rm -rf histo.hbk