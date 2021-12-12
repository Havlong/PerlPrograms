use strict;
use warnings FATAL => 'all';
use IO::Socket;

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $server_port = 1027;
my $my_tcp_server = IO::Socket::INET->new(
    LocalPort => $server_port,
    Type      => SOCK_STREAM,
    Reuse     => 1,
    Listen    => 20)
    or die "Can\'t use port:$server_port";

logmsg "server started on $server_port";

while (my $tcp_client = $my_tcp_server->accept()) {
    my $message = <$tcp_client>;
    print $message;
    close($tcp_client);
}

close($my_tcp_server);