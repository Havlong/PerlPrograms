#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin qw( $RealBin );
use lib $RealBin;
use student;

`chcp 65001`;

my $student1 = student->new({KEY => '18ВП11', NAME => 'Иванов И.И.', GROUP => '18ВП1', SPEC => 'Программная инженерия', GRADES => 'Отличник'});
my $student2 = student->new({KEY => '18ВП21', NAME => 'Петров П.П.', GROUP => '18ВП2', SPEC => 'Программная инженерия', GRADES => 'Хорошист'});
$student1->put_out;
$student2->put_out;