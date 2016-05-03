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
    cp -rf ../nuance_defaults_nc.cards .
    cp -rf ../cutnevt_nc1pi0.kumac .
    cp -rf ../../pi0_parameterize/missidwgt.f .
    cp -rf ../../pi0_parameterize/temp/selectcut_1pi0.inc .
    cp -rf ../ne1000.inc .
    cp -rf ${HOME}/.pawlogon.kumac .

    mares=900.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi0900=`${selfdir}/e2f.sh $pi0 5`

    mares=950.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi0950=`${selfdir}/e2f.sh $pi0 5`

    mares=1000.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01000=`${selfdir}/e2f.sh $pi0 5`

    mares=1050.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01050=`${selfdir}/e2f.sh $pi0 5`

    mares=1100.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01100=`${selfdir}/e2f.sh $pi0 5`

    mares=1150.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01150=`${selfdir}/e2f.sh $pi0 5`

    mares=1200.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01200=`${selfdir}/e2f.sh $pi0 5`

    mares=1250.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01250=`${selfdir}/e2f.sh $pi0 5`

    mares=1300.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    paw -b cutnevt_nc1pi0.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi01300=`${selfdir}/e2f.sh $pi0 5`

    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    echo "$EE $pi0900 $pi0950 $pi01000 $pi01050 $pi01100 $pi01150 $pi01200 $pi01250 $pi01300 $NCTOT" >> $output

    rm -rf *.hbk