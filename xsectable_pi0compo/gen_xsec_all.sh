#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    years=$3
    output=$4

    log=log.log
    alllog=all.log
    cutlog=cut.log
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults.cards .
    cp -rf ../cutnevt.kumac .
    cp -rf ../CCQEcut.f .
    cp -rf ../CCQEselectcut.inc .
    cp -rf ../ne1000.inc .
    cp -rf ../pawlogon.kumac .

    nuanceMc.exe -mono $nu $E -t IMB3 -nevt $years -h all.hbk ! > $log
    cp -rf all.hbk histo.hbk
    paw -b nevt_all.kumac > $alllog
    CCTOT=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    paw -b cutnevt_ccqeh.kumac > $cutlog # CCQE cut
    CCQEH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    paw -b cutnevt_ccqeo.kumac > $cutlog # CCQE cut
    CCQEO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    paw -b cutnevt_ccrsh.kumac > $cutlog # CCQE cut
    CCRSH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    paw -b cutnevt_ccrso.kumac > $cutlog # CCQE cut
    CCRSO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    echo "$EE $CCQEH $CCQEO $CCRSH $CCRSO $CCTOT" >> $output

    rm -rf histo.hbk