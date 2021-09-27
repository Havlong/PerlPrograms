#! /usr/bin/perl

print "Введите элементы первого множества\n";
@first = readSet();
print "Введите элементы второго множества\n";
@second = readSet();

sub readSet() {
    @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");

        $was = "";
        foreach $t (@list) {
            $was = ($t eq $_);
            last if ($was);
        }
        
        unless($was) {
            push(@list, $_);
        }
    }
    return @list;
}

@unity = @first;

foreach $t (@second) {
    $was = "";
    foreach $x (@first) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@unity, $t);
    }
}

@intersection = ();

foreach $t (@first) {
    $was = "";
    foreach $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    if ($was) {
        push(@intersection, $t);
    }
}

@substraction = ();

foreach $t (@first) {
    $was = "";
    foreach $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@subtraction, $t);
    }
}

@xor = ();
foreach $t (@first) {
    $was = "";
    foreach $x (@second) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@xor, $t);
    }
}
foreach $t (@second) {
    $was = "";
    foreach $x (@first) {
        $was = ($x eq $t);
        last if ($was);
    }
    
    unless($was) {
        push(@xor, $t);
    }
}

print "Первое множество: @first\n";
print "Второе множество: @second\n";
print "Объединение: @unity\n";
print "Пересечение: @intersection\n";
print "Разность первого и второго: @subtraction\n";
print "Симметричная разность: @xor\n";
