#!/usr/bin/perl
use warnings;
use strict;

use Term::ANSIColor;


my $info = (grep {$_ eq '--all'} @ARGV) ? `pacman -Si` : `pacman -Qi`;
push @ARGV, 4;
my $a = (grep {($_ =~ m/^\d+$/) and $_ > 0} @ARGV)[0];

my @list;
my $name;


$info =~ s/\n\s\s+/ /g;
foreach my $line (split "\n", $info)
{
  if ($line =~ m/^Name\s+:\s+(\S+)/)
  {
    $name = $1;
  }
  elsif ($line =~ m/^Description\s+:\s+(.+)$/)
  {
    push @list, "$name : $1";
  }
}


my $n = scalar @list;
my ($correct, $total, $streak, $best_streak) = (0,0,0,0);

my $ans;
while (1)
{
  my $c_name;
  my $c_desc;
  my @names;
  my $c = int(rand($a));
  for (my $i=0; $i<$a; $i++)
  {
    my ($name,$desc) = &split_line($list[int(rand($n))]);
    if (grep {$name eq $_} @names)
    {
      $i--;
      next;
    }
    push @names, $name;
    if ($i == $c)
    {
      ($c_name,$c_desc) = ($name,$desc);
      $c_desc =~ s/\Q$c_name\E/*/gi;
    }
  }
  print "description: $c_desc\n";
  my $j = 1;
  foreach my $name (@names)
  {
    print "$j) $name\n";
    $j++;
  }
  print "x) exit\n";
  print "answer: ";

  my $ans = <STDIN>;
  chomp $ans;
  last if (lc($ans) eq 'x');

  $total++;
  print "\n";
  if ($ans == $c + 1)
  {
    $correct++;
    $streak++;
    $best_streak = $streak if ($streak > $best_streak);
    print color ('bold green'), 'correct', color ('reset'), "\n";
  }
  else
  {
    $streak = 0;
    print color ('bold red'), 'incorrect', color ('reset'), " (answer: $c_name)\n";
  }
  print "current score: $correct/$total ",int(100 * $correct / $total),"%\n";
  print "current streak: $streak\n";
  print "best streak: $best_streak\n\n";
}

sub split_line
{
  return ($_[0] =~ m/^(\S+) : (.+?)\s*$/);
}
