#! /usr/bin/perl

print "Как Ваше имя?\n";
$name=<STDIN>;
print "Сколько вам лет?\n";
$age=<STDIN>;

$~=SALUT_FORMAT;
$^=SALUT_FORMAT_TOP;
write;

format SALUT_FORMAT=
Поздравляем Вас, ^>>>>>>>>>>>>>>>!
$name
Сегодня, в возрасте @###.## лет Вы написали
$age
свою первую Perl-программу !
.

format SALUT_FORMAT_TOP=
*******Первый сценарий на Perl*******
.