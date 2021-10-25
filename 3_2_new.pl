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

sub searchTree {
    my ($tree, $elementRef, $pos) = @_;
    return unless (defined $tree);
    $elementRef->[$pos] = $tree->{KEY};
    searchTree($tree->{L}, $elementRef, $pos << 1);
    searchTree($tree->{R}, $elementRef, ($pos << 1) + 1);
}

sub printTree {
    my ($tree) = @_;
    my @element = [];
    searchTree($tree, \@element, 1);
    my $size = 1;
    $size <<= 1 while($size <= $#element);

    for (my $i = 1; $i <= $size; $i = $i * 2) {
        for (my $z = 0; $z < ($size - 1) / $i; $z++) {
            print ' ';
        }
        for (my $j = $i; $j < ($i << 1) && $j <= $#element; $j++) {
            print $element[$j] if (defined $element[$j]);
            print ' ' unless (defined $element[$j]);
            for (my $z = 0; $z < ($size - 1) / $i; $z++) {
                print ' ';
            }
        }
        print "\n";
    }
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
            undef $tree;
            $_[0] = undef;
            return;
        }
        if (defined $tree->{L} && defined $tree->{R}) {
            my $rightMin = searchLeft($tree->{R});
            $tree->{KEY} = $rightMin;
            erase($tree->{R}, $rightMin);
            $_[0] = $tree;
            return;
        }
        if (defined $tree->{L}) {
            $_[0] = $tree->{L};
            undef $tree;
            return;
        }
        if (defined $tree->{R}) {
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
    last unless ($_ eq 1 || $_ eq 2 || $_ eq 3 || $_ eq 4);

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
    if ($_ == 4) {
        printTree($tree);
        print "\n";
    }

    write;
}

format CLI_FORMAT =
Выберите действие:
1 - Добавить элемент в дерево
2 - Удалить элемент из дерева
3 - Отобразить элементы дерева
4 - Отобразить рёбра
.
