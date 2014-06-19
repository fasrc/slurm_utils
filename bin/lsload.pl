#!/usr/bin/env perl
@lines = qx/scontrol -o show node/;
printf ("%-14s %6s %6s %6s %6s %6s %6s   %-15s\n","Hostname","Cores","InUse","Ratio","Load","Mem","Alloc","State");
foreach (@lines){
    chomp;
    ($reason) = $_ =~ /Reason=(.*)/;
    %data = map {/([^= ]+)/ => /=\s*(.*)/} split /\s+/;
    $data{'Reason'} = $reason;
   if ($data{'Arch'}){
        printf ("%-14s %6d %6d",$data{'NodeName'},$data{'CPUTot'},$data{'CPUAlloc'});
        if ($data{'CPUAlloc'} > 0){ printf (" %6.1f ",( $data{'CPUAlloc'} / $data{'CPUTot'} ) * 100); }
        else { printf (" %6.1f ", "0.0"); }
        printf ("%6.2f %6d %6d   %-15s ",$data{'CPULoad'},int($data{'RealMemory'} / 1000),int( $data{'AllocMem'} / 1000 ),$data{'State'});
        if ($data{'Reason'}) {print $data{'Reason'};}
        print "\n";
   }
   else {printf ("%-14s %6s %6s %6s %6s %6s %6s   %-15s %s\n",$data{'NodeName'}."(d)",0,0,0.0,0.00,0,0,"DOWN",$data{'Reason'});}
}

