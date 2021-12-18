use strict;
use warnings FATAL => 'all';
use IO::Socket;

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $server_port = 1027;
my $my_udp_server = IO::Socket::INET->new(
    LocalPort => $server_port,
    Type      => SOCK_DGRAM,
    Proto     => "udp")
    or die "Can\'t use port:$server_port";

logmsg "server started on $server_port";

while ($my_udp_server->recv(my $message, 20)) {
    print $message;
}

close($my_udp_server);