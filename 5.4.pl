#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

print("Введите исходный каталог: ");
my $source = <>;
chomp $source;

print("Введите конечный каталог: ");
my $destination = <>;
chomp $destination;

`mv $source $destination`;
