#! /bin/sh
a="18300000256.000000 "
b=${a%.*}
c="12547392.000000 Stunden"
d=${c%.*}
e="930977.000000 Stunden"
f=${e%.*}
g="0"
echo $a
echo $b
echo $c
echo $d
echo $e
echo $f
echo $g
/usr/bin/rrdtool update /usr/share/vito/vito.rrd N:1.800000:55.799999:46.299999:51.900002:20.000000:33.400002:20.000000:33.299999:20.000000:0:0:$b:$d:$f:0
/usr/share/vito/mailonerror.sh 0 0
