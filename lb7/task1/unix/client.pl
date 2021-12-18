use strict;
use warnings FATAL => 'all';
use Socket;

my $NAME = "socket";
socket(CLIENT, AF_UNIX, SOCK_STREAM, 0);
connect(CLIENT, sockaddr_un($NAME))
    or die "Can\'t connect to $NAME:$!";
my $message = "UNIX socket\n";
print CLIENT $message;
close(CLIENT);