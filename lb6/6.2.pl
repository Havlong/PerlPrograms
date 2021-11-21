#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub convertToRomanUtil {
    my ($n, $d) = @_;

    my $i = ('I', 'X', 'C', 'M')[$d];
    my $v = ('V', 'L', 'D')[$d];
    my $x = ('X', 'C', 'M')[$d];

    return $i x $n if $n >= 0 and $n <= 3;
    return ($i x (5 - $n)) . $v if $n == 4;
    return $v . ($i x ($n - 5)) if $n >= 5 and $n <= 8;
    return $i . $x;
}

sub convertToRoman {
    my ($n) = @_;

    return if $n !~ m/^\d+$/ or $n >= 4000;

    my $roman = '';
    for (my $d = 0; $n; $n = int($n / 10)) {
        $roman = convertToRomanUtil($n % 10, $d++) . $roman;
    }
    return $roman;
}

my $file, my $output = "D:\\PerlPrograms\\lb6\\output6_2.txt";

unless (defined $file) {
    print("Введите название файла: ");
    $file = <>;
    chomp $file;
}

open(INPUT, '<', $file) or die("Open failed: $!");
open(OUTPUT, '>', $output) or die("Open failed: $!");

undef $/;

while (my $str = <INPUT>) {
    my @list = ($str =~ m/\d+/g);
    foreach my $item (@list) {
        $str =~ s/$item/convertToRoman($item)/e;
    }
    print OUTPUT $str;
}
close(INPUT);
close(OUTPUT);

#D:\PerlPrograms\lb6\input6_2.txt