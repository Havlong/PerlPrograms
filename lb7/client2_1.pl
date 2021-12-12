use strict;
use warnings FATAL => 'all';
use IO::Socket;

my $remote_host = "localhost";
my $remote_port = 1027;
my $my_tcp_client = IO::Socket::INET->new(
    PeerAddr => $remote_host,
    PeerPort => $remote_port,
    Proto    => "tcp",
    Type     => SOCK_STREAM)
    or die "Can\'t connect to $remote_host!";
print $my_tcp_client "INET socket\n";
close($my_tcp_client);