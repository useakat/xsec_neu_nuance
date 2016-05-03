#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    years=$3
    output=$4
    mode=$5

    log=log.log
    cutlog=cut.log
if [ $mode -eq 2 ];then # NC pi0bg xsec after 1pi0cut & missID(polfit)
    kumac=cutnevt_nc1pi0.kumac
elif [ $mode -eq 3 ];then # NC 1pi0 xsec after 1pi0cut
    kumac=nevt_nc1pi0.kumac
elif [ $mode -eq 4 ];then # NC 1pi0 xsec after 1pi0cut $ missID(old)
    kumac=cutnevt_nc1pi0_oldmissid.kumac
fi
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults_nc.cards .
    cp -rf ../cutnevt_nc1pi0.kumac .
    cp -rf ../cutnevt_nc1pi0_oldmissid.kumac .
    cp -rf ../nevt_nc1pi0.kumac .
    cp -rf ../../pi0_parameterize/temp/* .
#    cp -rf ../../pi0_parameterize/temp/pi0cut.f .
#    cp -rf ../../pi0_parameterize/temp/missidwgt.f .
#    cp -rf ../../pi0_parameterize/temp/missidwgt_old.f .
#    cp -rf ../../pi0_parameterize/temp/selectcut_1pi0.inc .
#    cp -rf ../../pi0_parameterize/temp/func.inc .
    cp -rf ../ne1000.inc .
    cp -rf ${HOME}/.pawlogon.kumac .

    mares=900.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi0900=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=950.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi0950=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1000.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01000=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1050.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01050=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1100.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01100=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1150.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01150=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1200.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01200=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1250.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01250=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    mares=1300.
    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    nuanceMc.exe -mono $nu $E -t IMB3 -year $years -h nc1pi0.hbk ! > $log
    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01300=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    echo "$EE $pi0900 $pi0950 $pi01000 $pi01050 $pi01100 $pi01150 $pi01200 $pi01250 ${pi01300}" >> $output

    rm -rf *.hbk