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


print "Введите первый список:\n";
my @first = readList();
print "Введите второй список:\n";
my @second = readList();

my @unity = ();
for (my $i = 0; $i <= $#first || $i <= $#second; $i++) {
    push(@unity, $first[$i]) if ($i <= $#first);
    push(@unity, $second[$i]) if ($i <= $#second);
}

print "Объединённый список: @unity\n";
