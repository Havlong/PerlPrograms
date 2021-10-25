#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

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
my $root = <>;
chomp $root;
$root =~ s/\/\z//;

search($root, '') if (-d $root);


