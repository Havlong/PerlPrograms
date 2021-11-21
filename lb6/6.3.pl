#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub convertToArabicUtil($$) {
    my $fragment = shift;
    return 0 unless $fragment;
    my $d = shift;

    if ($d == 1) {
        $fragment =~ tr/XLC/IVX/;
    }
    elsif ($d == 2) {
        $fragment =~ tr/CDM/IVX/;
    }
    elsif ($d == 3) {
        $fragment =~ tr/M/I/;
    }

    $d = 10 ** $d;
    return $d * length($fragment) if $fragment =~ m/^I{1,3}$/;
    return $d * 4 if $fragment eq 'IV';
    return $d * (4 + length($fragment)) if $fragment =~ m/^VI{0,3}$/;
    return $d * 9;
}

sub convertToArabic($) {
    if (shift =~ m/^(M{0,3})(D?C{0,3}|C[DM])(L?X{0,3}|X[LC])(V?I{0,3}|I[VX])$/) {
        return convertToArabicUtil($1, 3) + convertToArabicUtil($2, 2) + convertToArabicUtil($3, 1) +
            convertToArabicUtil($4, 0);
    }
    return;
}

my $file, my $output = "D:\\PerlPrograms\\lb6\\output6_3.txt";

unless (defined $file) {
    print("Введите название файла: ");
    $file = <>;
    chomp $file;
}

open(INPUT, '<', $file) or die("Open failed: $!");
open(OUTPUT, '>', $output) or die("Open failed: $!");

undef $/;

while (my $str = <INPUT>) {
    my @list = ($str =~ m/\b((?:M{0,3}?(?:D?C{0,3}|C[DM])?(?:L?X{0,3}|X[LC])?(?:I{0,3}?V?I{0,3}|I[VX])))\b/gs);
    foreach my $item (@list) {
        if ($item ne '') {
            $str =~ s/$item/convertToArabic($item)/e;
        }
    }
    print OUTPUT $str;
}
close(INPUT);
close(OUTPUT);

#D:\PerlPrograms\lb6\input6_3.txt