use strict;
use warnings FATAL => 'all';
use Socket;

BEGIN {
    $ENV{PATH} = "/usr/bin:/bin"
}

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $NAME = "socket";

socket(SERVER, PF_UNIX, SOCK_STREAM, 0)
    or die "socket: $!";
unlink($NAME);
bind(SERVER, sockaddr_un($NAME))
    or die "bind: $!";
listen(SERVER, SOMAXCONN)
    or die "listen: $!";

logmsg "server started on $NAME";

for (; accept(CLIENT, SERVER); close(CLIENT)) {
    while (defined(my $message = <CLIENT>)) {
        print $message;
    }
}

close(SERVER);