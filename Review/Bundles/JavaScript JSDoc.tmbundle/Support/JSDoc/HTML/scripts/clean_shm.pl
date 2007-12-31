#!/usr/bin/perl 

# this script deletes all shared memory segments accessible by the
# running user.  Probably only works on Linux systems.

open(IPCS, 'ipcs |') or die "Probs opening icps : $!";

my $mode = 0;
while(<IPCS>) {
  if (/(Shared)|(Semaphore)|(Message)/) {
    $mode++;
    next;
  }
  next unless /^0x[0-9a-f]+\s(\d+)\s.*$/;
  system("ipcrm shm $1") if ($mode == 1);
  system("ipcrm sem $1") if ($mode == 2);
  system("ipcrm msg $1") if ($mode == 3);
}
