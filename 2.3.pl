#! /usr/bin/perl

print "Введите первый список:\n";
@first = readList();
print "Введите второй список:\n";
@second = readList();

@unity = ();
for ($i = 0; $i <= $#first && $i <= $#second; $i++) {
    push(@unity, @first[$i]);
    push(@unity, @second[$i]);
}

print "Объединённый список: @list\n";

sub readList() {
    @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");
        push(@list, $_);
    }
    return @list;
}