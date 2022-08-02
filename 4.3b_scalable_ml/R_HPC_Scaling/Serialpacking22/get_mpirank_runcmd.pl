#!/usr/bin/perl
use strict;
use warnings;
# -------------------------------------------------
# Perl 'wrapper' script to help launch tasks (ie a program)
# --------------------------------------------------

my ($myid, $numprocs) = split(/\s+/, `./getid_intel`); #getid will return cpu id and total processor in MPIjob

print("INFO,Perl script, you can run embarrasingly-parallel R here: $myid and mpisize: $numprocs \n");
sleep(60);

