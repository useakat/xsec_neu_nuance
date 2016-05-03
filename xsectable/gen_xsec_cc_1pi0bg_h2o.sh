#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    years=$3
    output=$4

    log=log.log
    cutlog_h=cut_h.log
    cutlog_o=cut_o.log
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults.cards .
    cp -rf ../cutnevt* .
    cp -rf ../CCQEcut* .
    cp -rf ../CCQEselectcut.inc .
    cp -rf ../ne1000.inc .
    cp -rf ../pawlogon.kumac .

#    process=CCQE
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_h.kumac > $cutlog_h # CCQE cut
    paw -b cutnevt_o.kumac > $cutlog_o # CCQE cut
    CCQEH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_h | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    CCQEO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog_o | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    CCRSH2=`expr $CCRSH + $CCDIH + $CCCOH + $CCDFH`
    CCRSO2=`expr $CCRSO + $CCDIO + $CCCOO + $CCDFO`
    echo "$EE $CCQEH $CCQEO $CCRSH2 $CCRSO2 $CCTOT" >> $output
#    echo "$EE $CCQEH $CCQEO $CCQEH1 $CCQEO2 100" >> $output

    rm -rf histo.hbk