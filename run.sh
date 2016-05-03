#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh"
    echo ""
    exit
fi
mail=1

echo `date`
echo $0

# xsec mode: 1:CCQE signal 2:NCpi0 BG(polfit) 3:NCpi0 4:NCpi0 BG(old) 5:Others
# dist mode: 0: None 1: Erec 2: mom

MACO=1030. # Default
MARES=1100. # Do not forget a decimal point. Otherwise NUANCE give a wrong answer...
proc=all
rm -rf pi0_parameterize/temp/funcs.inc

cp -rf funcs.inc pi0_parameterize/temp/funcs.inc
#cp -rf funcs_polfithigh.inc pi0_parameterize/temp/funcs.inc
#cp -rf funcs_polfitlow.inc pi0_parameterize/temp/funcs.inc
#cp -rf funcs_polfit2high.inc pi0_parameterize/temp/funcs.inc
#cp -rf funcs_polfit2low.inc pi0_parameterize/temp/funcs.inc

### CC cross sections
# nutype=ne
# ixsec=1
# xsec_mode=1
# dist_mode=1
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 0

# nutype=ae
# ixsec=1
# xsec_mode=1
# dist_mode=1
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 0

# nutype=nm
# ixsec=1
# xsec_mode=1
# dist_mode=1
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 0

# nutype=am
# ixsec=1
# xsec_mode=1
# dist_mode=1
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 0


### NC cross sections
sed -e "s/MACO/$MACO/" \
    -e "s/NCPROC/'NCQE' 'NCRS' 'NCDI' 'NCCO' 'NCDF'/" \
    -e "s/MARES/$MARES/" nuance_defaults_nc.cards > pi0_parameterize/temp/nuance_defaults_nc.cards
# run=NCpi0bg_polfit
# ixsec=0 # not used anymore
# xsec_mode=2
# dist_mode=1
# nutype=nm
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1
# nutype=am
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1

# run=NCpi0
# ixsec=0 # not used anymore
# xsec_mode=4
# dist_mode=1
# nutype=nm
# ./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1
#nutype=am
#./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1
#dist_mode=2
#nutype=nm
#./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1
#nutype=am
#./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1

run=NCpi0bg_old
ixsec=0 # not used anymore
xsec_mode=4
dist_mode=1
nutype=nm
./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1
#nutype=am
#./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc $nutype 1

# proc=ncco
# run=${proc}_dist_polfit.high
# ixsec=0
# xsec_mode=2
# dist_mode=1
# sed -e "s/MACO/$MACO/" \
#     -e "s/NCPROC/'NCRS'/" \
#     -e "s/MARES/$MARES/" nuance_defaults_nc.cards > pi0_parameterize/temp/nuance_defaults_nc.cards
# #./get_datatables.sh $run $ixsec $xsec_mode $dist_mode $proc 0

# MACO=1320. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=1210. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=1400. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=1100. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# run=ncco_xsec_maco${MACO}
# #run=ncrs_dist_mares${MARES}
# #run=nc1pi0_mares${MARES}
# #run=invpol_maco${MACO}
# ixsec=1
# xsec_mode=2
# dist_mode=0
# sed -e "s/MACO/$MACO/" \
#     -e "s/MARES/$MARES/" nuance_defaults_nc.cards > pi0_parameterize/temp/nuance_defaults_nc.cards
# #./get_datatables.sh $run $ixsec $xsec_mode $dist_mode 0

# MACO=740. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=990. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=800. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# #MARES=1100. # Do not forget the decimal point. Otherwise NUANCE give a wrong answer...
# run=ncco_xsec_maco${MACO}
# #run=ncrs_dist_mares${MARES}
# #run=nc1pi0_mares${MARES}
# #run=invpol_maco${MACO}
# ixsec=1
# xsec_mode=2
# dist_mode=0
# sed -e "s/MACO/$MACO/" \
#     -e "s/MARES/$MARES/" nuance_defaults_nc.cards > pi0_parameterize/temp/nuance_defaults_nc.cards
# #./get_datatables.sh $run $ixsec $xsec_mode $dist_mode 0

echo "Finished!"
echo `date`

if [ $mail -eq 1 ];then
    bsub -q e -J data_table -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
fi
