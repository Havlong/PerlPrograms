#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub solve {
    my ($n, $from, $to) = @_;
    my @tower = ('a'..'c');
    my $with = 3 - $from - $to;
    if ($n > 1) {
        solve($n - 1, $from, $with);
    }
    print "Перенос диска диаметра $n со стержня $tower[$from] на стержень $tower[$to]\n";
    if ($n > 1) {
        solve($n - 1, $with, $to);
    }
}

print "Введите количество дисков на стержне a: ";
my $n = <STDIN>;
chomp $n;
print "Решение для исходных данных:\n";
solve($n, '0', '2');

