#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub countMatches {
    my ($string, $pattern, $flag) = @_;
    my @count;
    if ($flag eq 'y') {
        @count = $string =~ /$pattern/g;
    }
    else {
        @count = $string =~ /$pattern/gi;
    }
    return scalar @count;
}

sub search {
    my ($dir, $pattern, $flag) = @_;

    opendir DIR, $dir;
    my @contents = readdir DIR;
    closedir DIR;

    foreach my $file (@contents) {
        next if ($file eq '.' || $file eq '..');
        my $filepath = "$dir\\$file";
        if (-d $filepath) {
            search($filepath, $pattern);
        }
        elsif (-f $filepath && countMatches($file, $pattern, $flag) > 0) {
            my $count = countMatches($file, $pattern, $flag);
            print "$file $count\n";
        }
    }
}

my $root, my $pattern, my $flag = '';

for (my $i = 0; $i <= $#ARGV; $i += 2) {
    if ($ARGV[$i] eq "-d") {
        $root = $ARGV[$i + 1];
    }
    elsif ($ARGV[$i] eq "-e") {
        $pattern = "$ARGV[$i + 1]";
    }
}

unless (defined $root) {
    print("Введите корневной каталог: ");
    $root = <>;
    chomp $root;
}

unless (defined $pattern) {
    print("Введите последовательность символов: ");
    $pattern = <>;
    chomp $pattern;
}

while ($flag ne 'y' && $flag ne 'n') {
    print("Поиск с учетом регистра? (y/n): ");
    $flag = <>;
    chomp $flag;
}

if ($flag eq 'y') {
    print "Количество вхождений $pattern в названия файлов, находящихся в $root, с учетом регистра\n";
}
else {
    print "Количество вхождений $pattern в названия файлов, находящихся в $root, без учета регистра\n";
}
search($root, $pattern, $flag) if (-d $root);

#D:\PerlPrograms\lb6\dir