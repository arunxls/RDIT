#!/usr/bin/perl

use File::Slurp;

my $thread = {};
my $lock = {};
my $mem = {};

my $thread_count = 0;
my $lock_count = 0;
my $mem_count = 0;
my $inputFile = $ARGV[0];
my $outputFile = $ARGV[1];

my @to_file = ();
foreach my $line (read_file( $inputFile )) {
    my @contents = split(' ', $line);
    my @output = ();
    foreach my $c (@contents) {
        if($c =~ /t(\d+)/) {
            if(! defined $thread->{$1}) {
                $thread->{$1} = $thread_count++;
            }
            $c = $thread->{$1};
        } elsif($c =~ /l0x(\d+)/) {
            if(! defined $lock->{$1}) {
                $lock->{$1} = $lock_count++;
            }
            $c = $lock->{$1};
        } elsif($c =~ /0x(.+)/) {
            if(! defined $mem->{$1}) {
                $mem->{$1} = $mem_count++;
            }
            $c = $mem->{$1};
        }
        push(@output, $c);
    }
    push(@to_file, join(' ', @output)."\n");
}

write_file($outputFile, @to_file);
