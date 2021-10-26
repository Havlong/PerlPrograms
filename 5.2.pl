#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

my $solutionFile = "fileTree.out";

sub search {
    my ($dir, $offset) = @_;

    if (-f $dir) {
        my $return = `ls -oh $dir`;
        print "$offset$return";
    }

    return unless (-d $dir);

    print "$offset$dir\n";

    opendir DIR, $dir;
    my @contents = readdir DIR;
    closedir DIR;

    my $newOffset = $offset . '  ';
    foreach my $file (@contents) {
        next if ($file eq '.' || $file eq '..');

        my $filepath = "$dir/$file";
        search($filepath, $newOffset);

    }
}

print("Введите корневной каталог: ");
my $root = <STDIN>;
chomp $root;
$root =~ s/\/\z//;

my $argsAmount = @ARGV;
open(STDOUT, '>', $solutionFile) if ($argsAmount > 0 && $ARGV[0] eq "file");
search($root, '') if (-d $root);
close STDOUT if ($argsAmount > 0 && $ARGV[0] eq "file");
