#! /usr/bin/perl

print "Введите список:\n";
@list = readList();
print "Исходный список: @list\n";

for ($i = 0; $i < $#list; $i += 2) {
    $t = @list[$i];
    @list[$i] = @list[$i + 1];
    @list[$i + 1] = $t;
}

print "Модифицированный список: @list\n";

sub readList() {
    @list = ();

    while (<STDIN>) {
        chomp;

        last if ($_ eq "");
        push(@list, $_);
    }
    return @list;
}