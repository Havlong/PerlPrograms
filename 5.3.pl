#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub endsWith {
    my ($string, $pattern) = @_;
    return $string =~ /\.$pattern\z/
}

sub search {
    my ($dir, $extension) = @_;

    opendir DIR, $dir;
    my @contents = readdir DIR;
    closedir DIR;

    foreach my $file (@contents) {
        next if ($file eq '.' || $file eq '..');
        my $filepath = "$dir/$file";
        if (-d $filepath) {
            search($filepath, $extension);
        }
        elsif (-f $filepath && endsWith($filepath, $extension)) {
            unlink $filepath;
        }

    }
}

my $root, my $extension;

for (my $i = 0; $i <= $#ARGV; $i += 2) {
    if ($ARGV[$i] eq "-d") {
        $root = $ARGV[$i + 1];
    }
    elsif ($ARGV[$i] eq "-e") {
        $extension = "$ARGV[$i + 1]";
    }
}

unless (defined $root) {
    print("Введите корневной каталог: ");
    $root = <>;
    chomp $root;
}
unless (defined $extension) {
    print("Введите расширение файлов для удаления: .");
    $extension = <>;
    chomp $extension;
}

$root =~ s/\/\z//;
$extension =~ s/\A\.//;

search($root, $extension) if (-d $root);


