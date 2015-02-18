#!/bin/perl
use strict;
use warnings;
use Carp;

exit main( @ARGV );

sub main
{
        my ($type, @args) = @_;
        return 1 unless $type;
        return handle_msg(@args) if $type eq 'MSG';
        return 1;
}

sub handle_msg
{
        my ($type, @args) = @_;
        return 1 unless $type;
        return handle_inc(@args) if $type eq 'IN';
        return handle_out(@args) if $type eq 'OUT';
        return 1;
}

sub handle_inc
{
        my ($who, $where) = @_;

        return 1 unless $who and $where;

        open(FILE, '<', $where) or croak "Unable to open $where!";
        my @lines = <FILE>;
        close(FILE);
        my $msg = join "", map { chomp $_; $_ = quotemeta $_; "$_\n"; } @lines;

        my $summary = "Incoming from \\\"$who\\\"";
        my $notify_cmd = "notify-send \"$summary\" \"$msg\"";
        my $sound_cmd = "aplay ~/.mcabber/sounds/receive.wav";

        system $notify_cmd;
        system $sound_cmd;

        unlink $where;
        return 0;
}

sub handle_out
{
        my ($who) = @_;
        return 1 unless $who;
        my $sound_cmd = "aplay ~/.mcabber/sounds/send.wav";
        system $sound_cmd;
        return 0;
}
