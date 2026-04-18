#!/bin/bash
l=$(echo -e "\r\n")
o="HEL\r\nLO HEL\nLO"
echo -e "$o--$(echo -e '\r\n')-"
echo -e "$o" | ./stdcar $'\r\n'
