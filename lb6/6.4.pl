#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

my $file, my $output = "D:\\PerlPrograms\\lb6\\output6_4.txt";

sub convertToKOI8 {
    my ($string) = @_;
    `iconv("windows-1251", "KOI8-R//IGNORE", $string)`;
    #`$string.decode('cp1251').encode('cp878')`;
}

unless (defined $file) {
    print("Введите название файла: ");
    $file = <>;
    chomp $file;
}

open(INPUT, '<', $file) or die("Open failed: $!");
open(OUTPUT, '>', $output) or die("Open failed: $!");

undef $/;

while (my $str = <INPUT>) {
    my @list = ($str =~ m/[C|D][\d|A-F]/g);
    foreach my $item (@list) {
        $str =~ s/$item/convertToKOI8($item)/e;
    }
    print OUTPUT $str;
}
close(INPUT);
close(OUTPUT);

#D:\PerlPrograms\lb6\input6_4.txt