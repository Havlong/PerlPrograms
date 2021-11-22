#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $file = "D:\\PerlPrograms\\lb6\\input6_4.txt", my $output = "D:\\PerlPrograms\\lb6\\output6_4.txt";

open(INPUT, '<:encoding(cp1251)', $file) or die("Open failed: $!");
open(OUTPUT, '>:encoding(koi8-r)', $output) or die("Open failed: $!");

undef $/;

while (my $str = <INPUT>) {
    print OUTPUT $str;
}
close(INPUT);
close(OUTPUT);

#D:\PerlPrograms\lb6\input6_4.txt