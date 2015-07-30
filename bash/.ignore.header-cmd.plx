#!/bin/perl

use strict;
use warnings;

main(@ARGV);

sub main
{
    my $args = {
        -pad        => 'x',
        -width      => 80,
        -title      => '',
        -ansi_line  => "\e[0m",
        -ansi_reset => "\e[0m",
        @_,
    };

    my $pad_w   = int($args->{-width} / 2) - int(length($args->{-title}) / 2);
    my $pad_lft = $args->{-pad} x $pad_w;
    my $pad_rgt = $pad_lft;

    chop($pad_lft) if (length($pad_lft . $args->{-title} . $pad_rgt)) > $args->{-width};

    my $all_txt
        = $args->{-ansi_line}
        . $pad_lft
        . $args->{-title}
        . $args->{-ansi_line}
        . $pad_rgt
        . $args->{-ansi_reset};

    print($all_txt);
}
