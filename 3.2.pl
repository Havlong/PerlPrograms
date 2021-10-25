#! /usr/bin/perl
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

sub printList {
    my ($tree) = @_;
    return unless (defined $tree);
    printList($tree->{L});
    print "$tree->{KEY} ";
    printList($tree->{R});
}

sub searchLeft {
    my ($tree) = @_;
    return $tree->{KEY} unless (defined $tree->{L});
    return searchLeft($tree->{L});
}

sub erase {
    my ($tree, $key) = @_;
    
    unless(defined $tree) {
        warn "Такого значения нет в дереве!\n";
        return;
    }
    
    if ($key < $tree->{KEY}) {
        erase($tree->{L}, $key);
    }
    if ($key > $tree->{KEY}) {
        erase($tree->{R}, $key);
    } 
    if ($key == $tree->{KEY}) {
        unless (defined $tree->{L} || defined $tree->{R}) {
            print "[DEBUG]: No children\n";
            undef $tree;
            $_[0] = undef;
            return;
        }
        if (defined $tree->{L} && defined $tree->{R}) {
            my $rightMin = searchLeft($tree->{R});
            $tree->{KEY} = $rightMin;
            print "[DEBUG]: Swap with $rightMin\n";
            erase($tree->{R}, $rightMin);
            $_[0] = $tree;
            return;
        }
        if (defined $tree->{L}) {
            print "[DEBUG]: Join L\n";
            $_[0] = $tree->{L};
            undef $tree;
            return;
        }
        if (defined $tree->{R}) {
            print "[DEBUG]: Join R\n";
            $_[0] = $tree->{R};
            undef $tree;
            return;
        }
    }
}

sub insert {
    my ($tree, $key) = @_;
    
    unless (defined $tree) {
        $tree = {};
        $tree->{KEY} = $key;
        $tree->{L} = undef;
        $tree->{R} = undef;
        $_[0] = $tree;
        return;
    }
    
    if ($key < $tree->{KEY}) {
        insert($tree->{L}, $key);
    } else {
        insert($tree->{R}, $key);
    }
}

sub generate {
    my ($tree, $arrayRef, $l, $r) = @_;

    return unless ($l <= $r);
    $tree = {};
    my $mid = int(($l + $r) / 2);

    $tree->{KEY} = $arrayRef->[$mid];
    $tree->{L} = undef;
    $tree->{R} = undef;

    unless ($l == $r) {
        generate ($tree->{L}, $arrayRef, $l, $mid - 1);
        generate ($tree->{R}, $arrayRef, $mid + 1, $r);
    }
    $_[0] = $tree;
}

sub readList {
    my @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");
        push(@list, $_);
    }
    return @list;
}

my $tree;
undef $tree if (defined $tree);

print "Введите исходный список для генерации дерева:\n";
my @list = readList();
my @array = sort {$a <=> $b} @list;

generate($tree, \@array, 0, $#array);

$~ = *CLI_FORMAT;
write;

while (<STDIN>) {

    chomp;
    last unless ($_ eq 1 || $_ eq 2 || $_ eq 3);

    if ($_ == 1) {

        print "Введите значение для добавления: ";
        my $x = <>;
        chomp $x;

        insert($tree, $x);
    }
    if ($_ == 2) {

        print "Введите значение для удаления: ";
        my $x = <>;
        chomp $x;

        erase($tree, $x);
    }
    if ($_ == 3) {
        printList($tree);
        print "\n";
    }

    write;
}

format CLI_FORMAT =
Выберите действие:
1 - Добавить элемент в дерево
2 - Удалить элемент из дерева
3 - Отобразить элементы дерева
.
