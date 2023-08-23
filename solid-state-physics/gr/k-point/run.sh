for k in 4 5 6 7 8 9 10 11 12 13 14; do
cat > kpoint.$k.in << EOF

&CONTROL
calculation  = 'scf'
pseudo_dir   = '../pseudo/'
outdir       = '../tmp/'
prefix       = 'gr'
/

&SYSTEM
ibrav        = 4
a            = 2.4623
c            = 10.0
nat          = 2
ntyp         = 1
occupations  = 'smearing'
smearing     = 'mv'
degauss      = 0.02
ecutwfc      = 40
/

&ELECTRONS
mixing_beta  = 0.7
conv_thr     = 1.0D-6
/

ATOMIC_SPECIES
C 12.0107 C.pbe-n-rrkjus_psl.0.1.UPF

ATOMIC_POSITIONS (crystal)
C  0.333333333  0.666666666  0.500000000
C  0.666666666  0.333333333  0.500000000

K_POINTS (automatic)
${k} ${k} 1 0 0 0

EOF
pw.x <kpoint.$k.in>kpoint.$k.out
echo " completed pw.x kpoint = $k"
awk '/!/ {printf"%d %s\n",'$k*$k',$5}' kpoint.$k.out >> calc-kpoint.dat
done
