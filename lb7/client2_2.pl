use strict;
use warnings FATAL => 'all';
use IO::Socket;

my $NAME = "socket";
my $UNIX_client = IO::Socket::UNIX->new(
    Peer    => $NAME,
    Timeout => 15)
    or die "Can\'t use socket :$!";
print $UNIX_client "UNIX socket\n";
close($UNIX_client);