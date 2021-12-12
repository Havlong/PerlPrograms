use strict;
use warnings FATAL => 'all';
use IO::Socket;

my $remote_host = "localhost";
my $remote_port = 1027;
my $socket = IO::Socket::INET->new(
    PeerAddr => $remote_host,
    PeerPort => $remote_port,
    Proto    => "tcp",
    Type     => SOCK_STREAM)
    or die "Can\'t connect to $remote_host!";

my $server_data = <$socket>;
print "Message from Server: $server_data \n";

my $client_data = "Hello from Client!";
print $socket "$client_data \n";

$socket->close();