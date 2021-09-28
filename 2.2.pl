#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub readList() {
    my @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");
        push(@list, $_);
    }
    return @list;
}


print "Введите список:\n";
my @list = readList();
print "Исходный список: @list\n";

for (my $i = 0; $i < $#list; $i += 2) {
    my $t = $list[$i];
    $list[$i] = $list[$i + 1];
    $list[$i + 1] = $t;
}

print "Модифицированный список: @list\n";
