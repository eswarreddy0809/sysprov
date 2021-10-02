import ipaddress
import struct

from socket import socket

dotted_address="192.168.23.13"
subnetlist       = [
               "192.168.1.0/22",
               "192.168.10.0/24",
               "192.168.20.0/22",
               "192.168.100.0/20",
               "192.168.101.0/24",
               ]; 
def subnets_have_host(subnetlist, dotted_address):
    for subnet in subnetlist:
        for address in ipaddress.ip_network(subnet,False):
             if address == ipaddress.IPv4Address(dotted_address):
                return 1;
             
if __name__ == "__main__":
    if subnets_have_host(subnetlist, dotted_address):
          print("Address is in subnet list")
    else:
          print("Address NOT in subnet list")
         
    
