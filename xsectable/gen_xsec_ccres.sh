#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    years=$3
    output=$4

    log=log.log
    cutlog=cut.log
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults.cards .
    cp -rf ../cutnevt.kumac .
    cp -rf ../CCQEcut.f .
    cp -rf ../CCQEselectcut.inc .
    cp -rf ../ne1000.inc .
    cp -rf ../pawlogon.kumac .

    process=CCQE
    nuanceMc.exe -mono $nu $E -t HCU -proc $process -year $years -h ccqeh.hbk ! > $log
    cp -rf ccqeh.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
#    CCQEH2=`sed -e '/Summary/d' -e '/generated/d' $log | sed -n '$p' | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    CCQEH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    nuanceMc.exe -mono $nu $E -t OCU -proc $process -year $years -h ccqeo.hbk ! > $log
    cp -rf ccqeo.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
#    CCQEO2=`sed -e '/Summary/d' -e '/generated/d' $log | sed -n '$p' | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    CCQEO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    process=CCRS
    nuanceMc.exe -mono $nu $E -t HCU -proc $process -year $years -h ccrsh.hbk ! > $log
    cp -rf ccrsh.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
#    CCRSH2=`sed -e '/Summary/d' -e '/generated/d' $log | sed -n '$p' | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    CCRSH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    nuanceMc.exe -mono $nu $E -t OCU -proc $process -year $years -h ccrso.hbk ! > $log
    cp -rf ccrso.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
#    CCRSO2=`sed -e '/Summary/d' -e '/generated/d' $log | sed -n '$p' | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    CCRSO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    process=CCDI
    nuanceMc.exe -mono $nu $E -t HCU -proc $process -year $years -h ccdih.hbk ! > $log
    cp -rf ccdih.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCDIH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    nuanceMc.exe -mono $nu $E -t OCU -proc $process -year $years -h ccdio.hbk ! > $log
    cp -rf ccdio.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCDIO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    process=CCCO
    nuanceMc.exe -mono $nu $E -t HCU -proc $process -year $years -h cccoh.hbk ! > $log
    cp -rf cccoh.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCCOH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    nuanceMc.exe -mono $nu $E -t OCU -proc $process -year $years -h cccoo.hbk ! > $log
    cp -rf cccoo.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCCOO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    process=CCDF
    nuanceMc.exe -mono $nu $E -t HCU -proc $process -year $years -h ccdfh.hbk ! > $log
    cp -rf ccdfh.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCDFH=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`
    nuanceMc.exe -mono $nu $E -t OCU -proc $process -year $years -h ccdfo.hbk ! > $log
    cp -rf ccdfo.hbk histo.hbk
    paw -b cutnevt.kumac > $cutlog # CCQE cut
    CCDFO=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES *=  *//' -e 's/ *ALL.*//'`

    nuanceMc.exe -mono $nu $E -t HHOU -year $years ! > $log
    CCTOT=`sed -e '/Summary/d' -e '/generated/d' $log | sed -n '$p' | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    CCRSH2=`expr $CCRSH + $CCDIH + $CCCOH + $CCDFH`
    CCRSO2=`expr $CCRSO + $CCDIO + $CCCOO + $CCDFO`
    echo "$EE $CCQEH $CCQEO $CCRSH2 $CCRSO2 $CCTOT" >> $output

    rm -rf histo.hbk