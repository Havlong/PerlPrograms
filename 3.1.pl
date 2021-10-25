#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub printList {
    my ($item) = @_;
    return unless (defined $item);
    print "Студент: $item->{INFO}->{NAME}\n";
    print "Номер зачётной книжки: $item->{KEY}\n";
    print "Номер группы: $item->{INFO}->{GROUP}\n";
    print "Специальность: $item->{INFO}->{SPEC}\n";
    print "Дата рождения: $item->{INFO}->{BIRTHDAY}\n";
    print "\n\n";
    printList($item->{NEXT});
}

sub erase {
    my ($cur, $myKey) = @_;
    
    unless(defined $cur) {
        warn "Такого значения нет в списке!\n";
        return;
    }
    
    if ($cur->{KEY} gt $myKey) {
        warn "Такого значения нет в списке!\n";
        return;
    } elsif ($cur->{KEY} lt $myKey) {
        erase($cur->{NEXT}, $myKey);
    } else {
        $_[0] = $cur->{NEXT};
        undef $cur;
    }
}

sub insert {
    my ($cur, $myKey, $myInfo) = @_;
    
    unless(defined $cur) {
        $cur = {};
        $cur->{KEY} = $myKey;
        $cur->{INFO} = $myInfo;
        $cur->{NEXT} = undef;
        $_[0] = $cur;
        return;
    }
    
    if ($cur->{KEY} eq $myKey) {
        warn "Такое значение уже есть в списке!\n";
    } elsif ($cur->{KEY} lt $myKey) {
        insert($cur->{NEXT}, $myKey, $myInfo);
    } else {
        my $newItem = {};
        $newItem->{NEXT} = $cur;
        $newItem->{INFO} = $myInfo;
        $newItem->{KEY} = $myKey;
        $_[0] = $newItem;
    }
}

my $list;
undef $list if (defined $list);

$~ = *CLI_FORMAT;
write;

while (<STDIN>) {

    chomp;
    last unless ($_ eq 1 || $_ eq 2 || $_ eq 3);

    if ($_ == 1) {

        print "Введите данные для добавления\n";
        print "Введите номер зачётной книжки: ";
        my $x = <>;
        chomp $x;
        my $info = {};

        print "Введите ФИО студента: ";
        $info->{NAME} = <>;
        chomp $info->{NAME};

        print "Введите Номер группы: ";
        $info->{GROUP} = <>;
        chomp $info->{GROUP};

        print "Введите Специальность: ";
        $info->{SPEC} = <>;
        chomp $info->{SPEC};

        print "Введите Год рождения: ";
        $info->{BIRTHDAY} = <>;
        chomp $info->{BIRTHDAY};

        insert($list, $x, $info);
    }
    if ($_ == 2) {

        print "Введите номер зачётной книжки: ";
        my $x = <>;
        chomp $x;

        erase($list, $x);
    }
    if ($_ == 3) {
        printList($list);
    }

    write;
}

format CLI_FORMAT =
Выберите действие:
1 - Добавить элемент в список
2 - Удалить элемент из списка
3 - Отобразить список
.
