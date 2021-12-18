use strict;
use warnings FATAL => 'all';
use Socket;

my $remote_port = 1027;
my $remote_host = 'localhost';
socket(CLIENT, PF_INET, SOCK_DGRAM, getprotobyname('udp'));
my $internet_addr = inet_aton($remote_host)
    or die "Couldn\'t build Internet address for $remote_host";
my $dest_addr = sockaddr_in($remote_port, $internet_addr);
my $message = "Inet socket\n";
send(CLIENT, $message, 0, $dest_addr);
close(CLIENT);