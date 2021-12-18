use strict;
use warnings FATAL => 'all';
use IO::Socket;

my $remote_host = 'localhost';
my $remote_port = 1027;
my $my_udp_client = IO::Socket::INET->new(
    PeerAddr => $remote_host,
    PeerPort => $remote_port,
    Type     => SOCK_DGRAM,
    Proto    => "udp")
    or die "Can\'t connect to $remote_host!";
print $my_udp_client "INET socket\n";
close($my_udp_client);