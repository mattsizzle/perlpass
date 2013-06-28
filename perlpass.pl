#!/usr/bin/perl

my @chars = ("A".."Z", "a".."z", "0".."9");
my $pass;
use Readonly;
Readonly my $count => 15;
foreach my $solid (1..$count) {$pass .= $chars[rand @chars];}
use Expect;
my $cmd = "passwd";
Readonly my $timeout => 30;
my $exp = Expect->new ;
     $exp->raw_pty(0);
     $exp->log_stdout(0);
     $exp->spawn("$cmd");
my $prompt = qr/assword:/xsm;
my $input = $exp->expect($timeout, [$prompt]);
$exp->send("$pass\n");
$input = $exp->expect($timeout, [$prompt]);
$exp->send("$pass\n");
$exp->soft_close();
print "Root password was set to: $pass\n";

