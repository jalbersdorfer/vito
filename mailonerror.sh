#!/bin/sh
echo $0
echo $1
echo $2

RECEIPIENTS=jalbersdorfer@me.com
SUBJECT="STOERUNG!!!"
MAIL=/tmp/stoerung.mail

STOERUNG=0

if test $1 -gt 0
then
	STOERUNG=1
fi

if test $2 -gt 0
then
	STOERUNG=1
fi

if test $STOERUNG -eq 1
then
	echo Subject: $SUBJECT > $MAIL
	echo Sammelstoerung = $1 >> $MAIL
	echo Brennerstoerung = $2 >> $MAIL
fi

if [ -f $MAIL ];
then
	sendmail $RECEIPIENTS < $MAIL
	rm -f $MAIL
fi
