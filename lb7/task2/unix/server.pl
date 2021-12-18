use strict;
use warnings FATAL => 'all';
use IO::Socket;

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $NAME = "socket";

unlink $NAME;

my $UNIX_server = IO::Socket::UNIX->new(
    Local  => $NAME,
    Listen => 15
) or die "Can\'t create socket :$!";

logmsg "server started on $NAME";

for (; accept(CLIENT, $UNIX_server); close(CLIENT)) {
    while (defined(my $message = <CLIENT>)) {print $message;
    }
}

close($UNIX_server);