#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    nevent=$3
    output=$4
    mode=$5
    proc=$6

    log=log.log
    cutlog=cut.log
if [ $mode -eq 2 ];then # NC pi0bg xsec after 1pi0cut & missID(polfit)
    if [ $proc == "all" ];then
	kumac=cutnevt_nc1pi0.kumac
    else
	kumac=nevt_nc1pi0_${proc}_polfit.kumac
    fi
elif [ $mode -eq 3 ];then # NC 1pi0 xsec after 1pi0cut
    if [ $proc == "all" ];then
	kumac=nevt_nc1pi0.kumac
    else
	kumac=nevt_nc1pi0_${proc}.kumac
    fi
elif [ $mode -eq 4 ];then # NC 1pi0 xsec after 1pi0cut $ missID(old)
    kumac=cutnevt_nc1pi0_oldmissid.kumac
elif [ $mode -eq 5 ];then # NC 1pi0 xsec after 1pi0cut & (1 -polfit)
    if [ $proc == "all" ];then
	kumac=nevt_nc1pi0_invpol.kumac
    else
	kumac=nevt_nc1pi0_invpol_${proc}.kumac
    fi
fi
    rm -rf $output
    touch $output
    cp -rf ../cutnevt_nc1pi0.kumac .
    cp -rf ../cutnevt_nc1pi0_oldmissid.kumac .
    cp -rf ../nevt_nc1pi0.kumac .
    cp -rf ../nevt_nc1pi0_* .
    cp -rf ../../pi0_parameterize/temp/* .
    cp -rf ../ne1000.inc .
    cp -rf ${HOME}/.pawlogon.kumac .

#    mares=1100.
#    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    mv nuance_defaults_nc.cards nuance_defaults.cards
#    nuanceMc.exe -mono $nu $E -t IMB3 -nevt $nevent -h histo.hbk ! > $log
    nuanceMc.exe -mono $nu $E -nevt $nevent -h histo.hbk ! > $log
#    nuanceMc.exe -mono $nu $E -t IMB3 -nevt $nevent -h nc1pi0.hbk ! > $log
#    cp -rf nc1pi0.hbk histo.hbk
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    paw -b $kumac > $cutlog 
    rm -rf *.hbk
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    pi01100=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    echo "$EE 0 0 0 0 $pi01100 0 0 0 0" >> $output