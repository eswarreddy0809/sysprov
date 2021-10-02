#!/usr/bin/perl

use Socket;

# 192.168.23.13 is in one of the subnets listed in $subnetlist
# There are four errors in this script.  Locate and fix the errors.

$dotted_address   = q|102.168.23.13|;

$subnetlist       = [
               '192.168.1.0/22',
               '192.168.10.0/24',
               '192.168.20.0/22',
               '192.168.100.0/20',
               '192.168.101.0/24',
               ];
#4 if condition inequality
if(!subnets_have_host($subnetlist, $dotted_address)) {
   printf("Address NOT in subnet list\n");
} else {
   printf("Address is in subnet list\n");
}

sub subnets_have_host {
   #1st error changed @args to @_
   my($subnets, $dotted_addr)  = @_;
   #3rd undef to 0
   my $stat    = undef;
   printf("Starting checks for %s...\n", $dotted_addr);

   my $address    = unpack('N', inet_aton($dotted_addr));
   foreach $subnet_w_bits (@{$subnets}) {
      my($subnet_dots, $bitmask)   = split(/\//, $subnet_w_bits);
      $subnet           = unpack('N', inet_aton($subnet_dots));
      my $wildcard      = (0xFFFFFFFF >> $bitmask);
      my $netmask       = (0xFFFFFFFF >> $bitmask) ^ 0xFFFFFFFF;
      my $broadcast     = $subnet | ($netmask | 0xFFFFFFFF);
      # if(($wildcard | $address) == $broadcast) {
      if(($netmask + $wildcard) == $broadcast) {
         $stat    = 1;
         printf("DotSubnet    : %s/%s\n", $subnet_dots, $bitmask);
         printf("IP           : %s\n", $dotted_addr);
         printf("\n");
         printf("Address      : %.32lb\n", $address);
         printf("Subnet       : %.32lb\n", $subnet);
         printf("Netmask      : %.32lb\n", $netmask);
         printf("Wildcard     : %.32lb\n", $wildcard);
         printf("Broadcast    : %.32lb\n", $broadcast);
         last;
      }
   }
   return($stat);
}
