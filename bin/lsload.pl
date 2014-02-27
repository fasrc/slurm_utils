#!/usr/bin/perl
@lines = qx/scontrol -o show node/;
printf ("%-14s %6s %6s %6s %6s %6s %6s   %-15s\n","Hostname","Cores","InUse","Ratio","Load","Mem","Alloc","State");
foreach (@lines){
  @e=split(" ",$_); @r=split("=",$_); $reason=pop(@r);
  chomp($reason);
  ($c,$cv)=split("=",$e[5]); ($cu,$cuv)=split("=",$e[3]);
  ($mu,$muv)=split("=",$e[13]); ($m,$mv)=split("=",$e[12]);
  ($n,$nv)=split("=",$e[0]); ($l,$lv)=split("=",$e[6]);
  ($s,$sv)=split("=",$e[16]); if ($e[1]=~/Arch/){
    printf ("%-14s %6d %6d",$nv,$cv,$cuv);
    if($cuv>0){ printf (" %6.1f ",($cuv/$cv)*100); }
    else { printf (" %6.1f ", "0.0"); }
    printf ("%6.2f %6d %6d   %-15s ",$lv,int($mv/1000),int($muv/1000),$sv);
    if ($reason!~ /n\/s/){print "$reason\n";}
    else {print "\n";}
  }
  else {printf ("%-14s %6s %6s %6s %6s %6s %6s   %-15s %s\n",$nv."(d)",0,0,0.0,0.00,0,0,"DOWN",$reason);}
}
