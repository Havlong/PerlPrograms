#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

my %list = ("entry" => "");

$~ = *CLI_FORMAT;
write;

while (<STDIN>) {

    chomp;
    last unless ($_ eq 1 || $_ eq 2 || $_ eq 3);

    if ($_ == 1) {

        print "Введите значение для добавления: ";
        my $x = <>;
        chomp $x;

        my $t = "entry";
        while ($list{$t} ne "" && $x gt $list{$t}) {
            $t = $list{$t};
        }
        unless ($x eq $list{$t}) {
            $list{$x} = $list{$t};
            $list{$t} = $x;
        }
    }
    if ($_ == 2) {

        print "Введите значение для удаления: ";
        my $x = <>;
        chomp $x;

        my $t = "entry";
        while ($list{$t} ne "" && $list{$t} ne $x) {
            $t = $list{$t};
        }
        if ($x eq $list{$t}) {
            $list{$t} = $list{$x};
            delete $list{$x};
        }
    }
    if ($_ == 3) {
        my $t = "entry";
        while ($list{$t} ne "") {
            print "$list{$t} ";
            $t = $list{$t};
        }
        print "\n";
    }

    write;
}

format CLI_FORMAT =
1 - Добавить элемент в список
2 - Удалить элемент из списка
3 - Отобразить список
.
