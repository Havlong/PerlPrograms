use strict;
use warnings FATAL => 'all';
use Socket;

sub logmsg {
    print "$0 $$: @_ at ", scalar localtime(), "\n"
}

my $server_port = 1027;

socket(SERVER, PF_INET, SOCK_DGRAM, getprotobyname('udp'));
setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1);
bind(SERVER, sockaddr_in($server_port, INADDR_ANY))
    or die "Can\'t create server:$!";
logmsg "server started on $server_port";

while (defined(my $message = <SERVER>)) {
    print $message;
    close(SERVER);
    last;
}