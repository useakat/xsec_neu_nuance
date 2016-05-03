#! /bin/bash
sed -n '$p' ne1000.log | sed -e 's/nu_ebar         : *//' -e 's/cc.*//' > xsec.dat

