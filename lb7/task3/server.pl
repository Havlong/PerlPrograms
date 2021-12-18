use strict;
use warnings FATAL => 'all';
use IO::Socket;

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $server_port = 1027;
my $socket = IO::Socket::INET->new(
    LocalPort => $server_port,
    Type      => SOCK_STREAM,
    Proto     => "tcp",
    Reuse     => 1,
    Listen    => 20)
    or die "Can\'t use port:$server_port";

logmsg "server started on $server_port";

my $client_socket = $socket->accept();

print "Connected from: ", $client_socket->peerhost();
print ", Port: ", $client_socket->peerport(), "\n";

my $server_data = "Hello from Server!\n";
print $client_socket "$server_data \n";

my $client_data = <$client_socket>;
print "Message from Client: $client_data\n";

$socket->close();