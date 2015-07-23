#!/bin/perl

use strict;
use warnings;

main(@ARGV);

sub main
{
    my $args = {
        -pad    => 'x',
        -width  => 80,
        -title  => '',
        @_,
    };

    my $pad_w   = int($args->{-width} / 2) - int(length($args->{-title}) / 2);
    my $pad_txt = $args->{-pad} x $pad_w;
    my $all_txt = $pad_txt . $args->{-title} . $pad_txt;

    chop($all_txt) if (length $all_txt) > $args->{-width};

    print("$all_txt\n");
}
