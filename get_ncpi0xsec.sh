#! /bin/bash
xsec_mode=2 # 1:CCQE signal 2:NCpi0bg(polfit) 3:NCpi0 4:NCpi0bg(old)
dist_mode=2 # 0: None 1:NCpBG(polfit) Erec 2:NCpi0 mom 3:NCpi0BG(old) Erec 4:NCpi0 Erec

echo "Making NC-pi0 Cross section Table"
cd xsec_table
sed -e "s/mode=./mode=$xsec_mode/" run.sh > run.tmp
mv run.tmp run.sh
chmod +x run.sh
./run.sh
rm -rf run.tmp

if [ $dist_mode -ne 0 ];then
    echo "Making NC-pi0 distribution Table"
    cd ../pi0_parameterize
    sed -e "s/mode=./mode=$dist_mode/" run.sh > run.tmp
    mv run.tmp run.sh
    chmod +x run.sh
fi