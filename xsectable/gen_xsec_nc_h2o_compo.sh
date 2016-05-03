#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    nevent=$3
    output=$4
    mode=$5

    echo "Entering" > status.txt
    log=log.log
    cutlog=cut.log
if [ $mode -eq 2 ];then # NC pi0bg xsec after 1pi0cut & missID(polfit
    echo "if" > status.txt
    kumac=nevt_nc1pi0_polfit
#    kumac=nevt_nc1pi0_polfit_ncrs.kumac
#    kumac=nevt_nc1pi0_polfit_ncco.kumac
#    kumac=nevt_nc1pi0_polfit_ncdi.kumac
#    kumac=nevt_nc1pi0_polfit_ncqe.kuma
elif [ $mode -eq 3 ];then # NC 1pi0 xsec after 1pi0cut
    kumac=nevt_nc1pi0
#    kumac=nevt_nc1pi0_ncrs.kumac
#    kumac=nevt_nc1pi0_ncco.kumac
#    kumac=nevt_nc1pi0_ncdi.kumac
#    kumac=nevt_nc1pi0_ncqe.kuma
elif [ $mode -eq 4 ];then # NC 1pi0 xsec after 1pi0cut $ missID(old)
    kumac=nevt_nc1pi0_oldmissid
elif [ $mode -eq 5 ];then # NC 1pi0 xsec after 1pi0cut & (1 -polfit)
    kumac=nevt_nc1pi0_invpol
#    kumac=nevt_nc1pi0_invpol_ncrs.kumac
#    kumac=nevt_nc1pi0_invpol_ncco.kumac
#    kumac=nevt_nc1pi0_invpol_ncdi.kumac
#    kumac=nevt_nc1pi0_invpol_ncqe.kumac
fi
    rm -rf $output
    touch $output
    cp -rf ../nevt_nc1pi0* .
    cp -rf ../../pi0_parameterize/temp/* .
    cp -rf ${HOME}/.pawlogon.kumac .

#    mares=1100.
#    sed -e "s/MARES/${mares}/" nuance_defaults_nc.cards > nuance_defaults.cards
    mv nuance_defaults_nc.cards nuance_defaults.cards

    nuanceMc.exe -mono $nu $E -nevt $nevent -h histo.hbk ! > $log
    NCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    process=NCQE
    paw -b ${kumac}_ncqe.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    NCQE=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    process=NCRS
    paw -b ${kumac}_ncrs.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    NCRS=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    process=NCDI
    paw -b ${kumac}_ncdi.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    NCDI=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    process=NCCO
    paw -b ${kumac}_ncco.kumac > $cutlog 
    pi0=`sed -e '/Exiting/d' -e '/MEAN VALUE/d' -e '/UNDERFLOW/d' $cutlog | sed -n '$p' | sed -e 's/ *ENTRIES .*ALL CHANN *=//'`
    pi02=`${selfdir}/e2f.sh $pi0 5`
    NCCO=`echo "scale=5; ${pi02}/${NCTOT}" | bc | sed 's/^\./0./'`

    #rm -rf *.hbk

    NC1pi0TOT=`echo "scale=5; $NCQE +$NCRS +$NCDI +$NCCO" | bc | sed 's/^\./0./'`
    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
    echo "$EE $NCQE $NCRS $NCDI $NCCO $NC1pi0TOT" >> $output
    echo "$EE $NCQE $NCRS $NCDI $NCCO $NC1pi0TOT"