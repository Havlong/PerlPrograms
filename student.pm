#!/usr/bin/perl
package student;
use strict;
use warnings FATAL => 'all';

`chcp 65001`;

require Exporter;
our @ISA= qw (UNIVERSAL Exporter);
our @EXPORT = qw(new DESTROY put_out);

sub new {
    my ($class,$args) = @_;
    bless {KEY => $args->{KEY},
        NAME => $args->{NAME},
        GROUP => $args->{GROUP},
        SPEC => $args->{SPEC},
        GRADES => $args->{GRADES}
    }, $class;
}

sub DESTROY {
    my $ref =shift;
    foreach my $class (@ISA) {
        my $destroy = "${class}::DESTROY";
        $ref->$destroy if $ref->can($destroy);
    }
}

sub put_out {
    my $ref = shift;
    print "Студент:\nНомер зачетной книжки: $ref->{KEY}\nФИО: $ref->{NAME}\nГруппа: $ref->{GROUP}\nСпециальность: $ref->{SPEC}\nУспеваемость: $ref->{GRADES}\n\n";
}

1;