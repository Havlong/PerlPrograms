#! /usr/bin/perl

print "Введите день\n";
$day = <STDIN>;
print "Введите месяц\n";
$month = <STDIN>;
print "Введите год\n";
$year = <STDIN>;

$firstMember = "Скворцова Екатерина";
$secondMember = "Гришин Евгений";
$thirdMember = "Гумберидце Артур";

$~ = INFO;
$^ = INFO_TOP;
$= = 4;

write;

format INFO = 
Сегодняшняя дата: @##.@##.@####
($day, $month, $year)
Состав бригады:
^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$firstMember
^||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$secondMember
^>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
$thirdMember
.

format INFO_TOP = 
Лабораторная работа №1
Общая структура программы. 
Ввод и вывод информации. Форматы.
.