#!/usr/bin/perl

use strict;
use warnings;

use File::stat;
use Time::localtime;

# === Configuration ===
my $minKesselTemp = 50.0;
my $minSpeicherTemp = 40.0;
my $mailAddress = "jalbersdorfer\@me.com";
my $mailSubject = "Stoerung im Heizungssystem?!";
my $mailThreshold = 1 * 60 * 60; # 1 hour

# === Avoid modification below that line ===
my $temp1 = $ARGV[0];
my $temp2 = $ARGV[1];

my $sendmail = 0;
my $message = "";
if ($temp1 < $minKesselTemp) {
	$sendmail = 1;
	$message = $message . sprintf("Kessel hat %.1f, sollte > %.1f sein.\n", $temp1, $minKesselTemp);
}

if ($temp2 < $minSpeicherTemp) {
	$sendmail = 1;
	$message = $message . sprintf("Speicher hat %.1f, sollte > %.1f sein.\n", $temp2, $minSpeicherTemp);
}

my $lastmailfile = "/usr/share/vito/lastmail";
my $lastmail = 0;
if (-f $lastmailfile) {
	$lastmail = stat($lastmailfile)->mtime;
}
print sprintf("Lastmail = %d\n", $lastmail);
my $now = time();
my $sendok = ($now - $lastmail > $mailThreshold) ? 1 : 0;
if ($sendmail == 1 && $sendok == 1) {
	&send_mail(
	$mailAddress,
	$mailAddress,
	$mailAddress,
	$mailSubject,
	$message
	);

	# Save time of last mail sent.
	open (MYFILE, '>'.$lastmailfile);
	print MYFILE ctime($now);
	close (MYFILE);
}

sub send_mail{
local *SENDMAIL;
my $ok='';
my $SENDMAIL='';

my $returnadresse=shift;
my $to=shift;
my $from=shift;
my $subject=shift;
my $mailtext=shift;

# gültige Zeichen in Mailadressen sind:
# a-z A-Z 0-9 _ \- \+ \* \$ \. \@
# falls andere Zeichen auftreten -> STOPP
die ('wrong returnadresse') if ($returnadresse=~ /[^a-zA-Z0-9_\-\+\*\$\.\@]/);
die ('wrong to:') if ($to=~ /[^a-zA-Z0-9_\-\+\*\$\.\@]/);
die ('wrong from:') if ($from=~ /[^a-zA-Z0-9_\-\+\*\$\.\@]/);
die ('no mailtext') if ($mailtext eq '');
die ('no subject') if ($subject eq '');
die ('wrong subject') if ($subject=~ /[\n\0\t\r\0\|]/);

my @sendmails=(
'/usr/sbin/sendmail',
'/usr/bin/sendmail',
'/usr/lib/sendmail'
);

# prüfen, wo sendmail sich befindet
foreach (@sendmails){
if (open (SENDMAIL,"|$_ -t")){
$SENDMAIL=$_;
close SENDMAIL;
last;
}
}

die ('Can not find sendmail!!!') if ($SENDMAIL eq '');

open (SENDMAIL,"|$SENDMAIL -t -f $returnadresse") || die('can not open sendmail');
print SENDMAIL <<EOF;
To: $to
Subject: $subject
From: $from
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


$mailtext
EOF
close SENDMAIL;
}
