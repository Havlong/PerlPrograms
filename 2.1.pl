#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub readSet() {
    my @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");

        my $was = "";
        foreach my $t (@list) {
            $was = ($t eq $_);
            last if ($was);
        }

        unless ($was) {
            push(@list, $_);
        }
    }
    return @list;
}

print "Введите элементы первого множества\n";
my @first = readSet();
print "Введите элементы второго множества\n";
my @second = readSet();

my @unity = @first;

foreach my $t (@second) {
    my $was = "";
    foreach my $x (@first) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@unity, $t);
    }
}

my @intersection = ();

foreach my $t (@first) {
    my $was = "";
    foreach my $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    if ($was) {
        push(@intersection, $t);
    }
}

my @subtraction = ();

foreach my $t (@first) {
    my $was = "";
    foreach my $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@subtraction, $t);
    }
}

my @xor = ();
foreach my $t (@first) {
    my $was = "";
    foreach my $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@xor, $t);
    }
}
foreach my $t (@second) {
    my $was = "";
    foreach my $x (@first) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@xor, $t);
    }
}

print "Первое множество: @first\n";
print "Второе множество: @second\n";
print "Объединение: @unity\n";
print "Пересечение: @intersection\n";
print "Разность первого и второго: @subtraction\n";
print "Симметричная разность: @xor\n";
