#! /bin/sh
#date > /usr/share/vito/lastrun
#/usr/local/bin/vclient -h localhost:3003 -f /usr/share/vito/commands -t /usr/share/vito/vito.tmpl -x /usr/share/vito/script.sh

rrdtool graph /usr/share/vito/vito7d.png -a PNG \
--start end-7d  --end now --width 800 --height 300 \
--title 'Vito-Messwerte' \
DEF:TempATS=/usr/share/vito/vito.rrd:TempATS:AVERAGE \
DEF:TempKTS=/usr/share/vito/vito.rrd:TempKTS:AVERAGE \
DEF:TempKTSoll=/usr/share/vito/vito.rrd:TempKTSoll:AVERAGE \
DEF:TempSTS=/usr/share/vito/vito.rrd:TempSTS:AVERAGE \
DEF:TempAGTS=/usr/share/vito/vito.rrd:TempAGTS:AVERAGE \
DEF:TempVLTSM1=/usr/share/vito/vito.rrd:TempVLTSM1:AVERAGE \
DEF:TempRLTSM1=/usr/share/vito/vito.rrd:TempRLTSM1:AVERAGE \
DEF:TempVLTSM2=/usr/share/vito/vito.rrd:TempVLTSM2:AVERAGE \
DEF:TempRLTSM2=/usr/share/vito/vito.rrd:TempRLTSM2:AVERAGE \
DEF:SammelStoerung=/usr/share/vito/vito.rrd:SammelStoerung:AVERAGE \
DEF:BrennerStoerung=/usr/share/vito/vito.rrd:BrennerStoerung:AVERAGE \
DEF:BrennerStatus=/usr/share/vito/vito.rrd:BrennerStatus:AVERAGE \
CDEF:GSammelStoerung=SammelStoerung,10,* \
CDEF:GBrennerStoerung=BrennerStoerung,10,* \
CDEF:GBrennerStatus=BrennerStatus,10,* \
LINE1:TempATS#0000FF:Aussen \
LINE1:TempKTS#FF8C00:Kessel \
LINE1:TempKTSoll#FF8C00:Kessel-Soll:dashes \
LINE1:TempSTS#BDB76B:Speicher \
LINE1:TempAGTS#808080:Abgas \
LINE1:TempVLTSM1#E9967A:VorlM1 \
LINE1:TempRLTSM1#8FBC8F:RuecklM1 \
LINE1:TempVLTSM2#4b0082:VorlM2 \
LINE1:TempRLTSM2#4b0082:RuecklM2 \
LINE2:GSammelStoerung#FF0000:SammelStoerung \
LINE2:GBrennerStoerung#800000:BrennerStoerung \
LINE1:GBrennerStatus#555555:BrennerStatus \
VDEF:TempATSmax=TempATS,MAXIMUM \
VDEF:TempATSmin=TempATS,MINIMUM \
VDEF:TempKTSmax=TempKTS,MAXIMUM \
VDEF:TempKTSmin=TempKTS,MINIMUM \
COMMENT:"\l" \
COMMENT:"Aussentemp." \
GPRINT:TempATSmin:"    Min. %02.1lf Grad C" \
GPRINT:TempATSmax:"Max. %02.1lf Grad C" \
COMMENT:"\l" \
COMMENT:"Kesseltemp." \
GPRINT:TempKTSmin:"    Min. %02.1lf Grad C" \
GPRINT:TempKTSmax:"Max. %02.1lf Grad C"

cp /usr/share/vito/vito7d.png /usr/share/nginx/www/

# date >> /usr/share/vito/lastrun
