###################### Options ###########################################
#set title "gg -> ng Cross Section"
#set logscale x
#set logscale y
#set format x "%L"
#set format y "10^{%L}"
#set xtics (2,3,4,5,6)
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)
#set tics scale 2
#set key at 1.0E3,1.0E7 samplen 2
#set xlabel 'Final gluons' offset 0,0
#set ylabel 'Cross Section (fb)' offset 0,0
#set xrange [1:7]
#set yrange [1E-5:2E8]
####################### Definitions ######################################
file1 = 'ae_xsec.dat'

c1 = 'red'
c2 = 'blue'
c3 = '#006400' # dark green
c4 = 'purple'
c5 = '#ff33ff'
c6 = '#cc6600' # dark orange

#set pointsize 1.9
##########################################################################
set terminal postscript eps enhanced "Helvetica" color 24
set output "ae_xsec.eps"
set grid
set key spacing 1.5 samplen 2.5 at graph 0.5,0.6
set multiplot

#set title "{/=28 Xsec Ratio" offset 0,-0.5
set xlabel '{/=34 E_{nu} (GeV)' offset
set ylabel '{/=34 Xsec Ratio}' offset
#set format x "%3.1f"
#set format y "%3.1f"
#set xtics (0,0.2,0.4,0.6,0.8,1,1.2,1.4,1.6,1.8,2)
#set xrange [0:2]
#set yrange [0:35]
#################### plot ##########################################
plot \
file1 u 1:($2/($2+$3)) title "CCQE-H" w l lt 1 lw 5 lc rgb c1 ,\
file1 u 1:($3/($2+$3)) title "CCQE-O" w l lt 2 lw 5 lc rgb c1 ,\
file1 u 1:($4/($4+$5)) title "RES-H" w l lt 1 lw 5 lc rgb c2 ,\
file1 u 1:($5/($4+$5)) title "RES-O" w l lt 2 lw 5 lc rgb c2
###########################################################################
set nomultiplot
reset

## plots
#file1 u 1:2 title "fit" w l lt 1 lw 5 lc rgb c1
#file1 u 1:2 title "fit" w steps lt 1 lw 5 lc rgb c1
## pointtype (pt)
# 5: filled square
# 6: open circle
# 7: filled circle
# 12: open diamond
# 13: filled diamond