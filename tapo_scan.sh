#!/usr/bin/bash
nmap -sP 192.168.1.0/24 &> /dev/null
arp -an | awk '$4~"^(9c:a2:f4|ac:15:a2)" {print $2}' |tr -d '()' | sort | while read -r line
do
  printf "  - %s\n" "$line"
done
