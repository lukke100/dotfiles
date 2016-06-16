#!/bin/perl

use 5.14.0;
use Encode;
use IO::Handle;
use strict;
use utf8;
use warnings;

binmode(STDOUT, ':encoding(UTF-8)');
main(@ARGV);

sub main
{
  my $args = {
    -pad        => 'x',
    -width      => 80,
    -title      => '',
    -ansi_line  => "\e[0m",
    -ansi_title => "\e[0m",
    -ansi_reset => "\e[0m",
    map { Encode::decode_utf8($_) } @_,
  };

  my $pad_w   = int($args->{-width} / 2) - int(length($args->{-title}) / 2);
  my $pad_lft = $args->{-pad} x $pad_w;
  my $pad_rgt = $pad_lft;

  chop($pad_rgt) if (length($pad_lft . $args->{-title} . $pad_rgt)) > $args->{-width};

  my $all_txt
    = $args->{-ansi_line}
    . $pad_lft
    . $args->{-ansi_title}
    . $args->{-title}
    . $args->{-ansi_line}
    . $pad_rgt
    . $args->{-ansi_reset};

  STDOUT->print($all_txt);
}
