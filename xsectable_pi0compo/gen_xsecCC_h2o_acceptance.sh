#! /bin/bash
selfdir=$(cd $(dirname $0);pwd)
    nu=$1
    E=$2
    events=$3

    output=CCQE_xsec_acc_table.dat
    log=log.log
    log_h=h.log
    log_o=o.log
    cutlog_h=cut_h.log
    cutlog_o=cut_o.log
    rm -rf $output
    touch $output
    cp -rf ../nuance_defaults_cc.cards nuance_defaults.cards
    cp -rf ../nevt_* .
    cp -rf ../cut_* .
    cp -rf ../*_h.f .
    cp -rf ../*_o.f .
    cp -rf ../*_h.kumac .
    cp -rf ../*_o.kumac .    
    cp -rf ../cutnevt* .
    cp -rf ../ccqecut* .
    cp -rf ../ccqeselectcut.inc .
    cp -rf ../ne1000.inc .
    cp -rf ${HOME}/.pawlogon.kumac .
    target=IMB3

    echo "BeforeCut" "AfterCut" "Acc." >> $output
    nuanceMc.exe -mono $nu $E -t $target -nevt $events -h histo.hbk ! > $log

    process=CCQE
    kumac_h=nevt_ccqe_h.kumac
    kumac_o=nevt_ccqe_o.kumac
    kumac_cut_h=cutnevt_ccqe_h.kumac
    kumac_cut_o=cutnevt_ccqe_o.kumac
    source $selfdir/acc_unit.sh

    process=CCRS
    kumac_h=nevt_ccrs_h.kumac
    kumac_o=nevt_ccrs_o.kumac
    kumac_cut_h=cutnevt_ccrs_h.kumac
    kumac_cut_o=cutnevt_ccrs_o.kumac
    source $selfdir/acc_unit.sh

    process=CCCO
    kumac_h=nevt_ccco_h.kumac
    kumac_o=nevt_ccco_o.kumac
    kumac_cut_h=cutnevt_ccco_h.kumac
    kumac_cut_o=cutnevt_ccco_o.kumac
    source $selfdir/acc_unit.sh

    process=CCDI
    kumac_h=nevt_ccdi_h.kumac
    kumac_o=nevt_ccdi_o.kumac
    kumac_cut_h=cutnevt_ccdi_h.kumac
    kumac_cut_o=cutnevt_ccdi_o.kumac
    source $selfdir/acc_unit.sh

    CCTOT=`grep "NUGENE finished" $log | sed -e 's/ NUGENE finished after: *//' -e 's/good.*//'`
    echo "Total" $CCTOT >> $output

#    EE=`echo "scale=5;$E/1000" | bc | sed -e 's/^\./0./'`
#    CCRSH2=`expr $CCRSH + $CCDIH + $CCCOH + $CCDFH`
#    CCRSO2=`expr $CCRSO + $CCDIO + $CCCOO + $CCDFO`
#    echo "$EE $CCQEH $CCQEO $CCRSH2 $CCRSO2 $CCTOT" >> $output
#    echo "$EE $CCQEH $CCQEO $CCQEH1 $CCQEO2 100" >> $output

#    rm -rf *.hbk