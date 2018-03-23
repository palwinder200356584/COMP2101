#!/bin/bash
#Bash Mid-semester final assignment
#COMP 2101 MONDAY Morning Class
#Name:Palwinder Kaur
#Student ID:200356584
# This content actualizes the tasks in the bash semester assignment
# Proclaim variables and assign any default values.
# Define functions for error messages and displaying command line help.

nullmode="yes"

#Using variables to make the task easy and getting requestrd outputs easily.

function shortcmds {
  echo "
  One or more outputs can be shown for the following:
  $0 [-hc | --help]
  $0 [-dn | --domain name and host name]
  $0 [-ip | --Display IP address of system]
  $0 [-cs | --CPU details]
  $0 [-ri | --RAM information]
  $0 [-on | --Name of Operating System]
  $0 [-os | --Version of Operating System]
  $0 [-da | --Available Disk Space]
  $0 [-pi | --Installed Printers list]
  "
}

function errorinfos {
  echo "$@" >&2
}
# using the variables to get output and to narrowing the output field.

while [ $# -gt 0 ]; do
  case "$1" in
    -hc|--help)
    shortcmds
    nullmode="no"
    ;;

    -dn)
    domaindetailofhost="yes"
    nullmode="no"
    ;;

    -ip)
    IPaddressofhost="yes"
    nullmode="no"
    ;;

    -cs)
    CPUinfoofhost="yes"
    nullmode="no"
    ;;

    -ri)
    memorydetailofhost="yes"
    nullmode="no"
    ;;

    -on)
    operatingsystemdetailsofhost="yes"
    nullmode="no"
    ;;

    -os)
    Operatingsystemversionofhost="yes"
    nullmode="no"
    ;;

    -da)
    diskspacedetailsofhost="yes"
    nullmode="no"
    ;;

    -pi)
    printerdetailsofhost="yes"
    nullmode="no"
    ;;
    *)
    errorinfos "
    '$1' wrong entry"
    exit 1
    ;;
  esac
    shift
  done

#variables that contain some values used in this script for output field.

domainname="$(grep PRETTY /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"

ipaddress="$(hostname -I)"

CPUinfo="$(cat /proc/cpuinfo | grep 'model name' | uniq)"

RAMinfo="$(cat /proc/meminfo | grep MemTotal)"

osinfo="$(grep PRETTY /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"

osversion="$(grep PRETTY /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"

diskinfomration="$(df -m /tmp | tail -1 | awk '{print $4}')"

printerinfo="$(lpstat -p | awk '{print $2}')"

#testing the output using command line

#Details of Domain and Host name
hostnameinfoforsystem="
Hostname: $systemname
Domain Name=$domainname
"

#IP address Details
ipaddressinfoforsystem="
IP Address Informantion:
IP Address: $ipaddress
"

#CPU details
CPUinfoforsystem="
CPU Information:
CPU Info: $CPUinfo
"

#RAM details
RAMinfoforsystem="
RAM Info:
RAM Installed: $RAMinfo
"
#Operating system name
OSinfoforsystem="
Operating System Information:
Operating System Installed: $osinfo
"
#OSversion details
OSversioninfoforsystem="
Operating System Version Info:
OS Version: $osversion
"
#Disk space Available
Diskspaceinfoforsystem="
Disc Space Information:
Disc Space: $discspace
"
#Printer INFORMATION
Printerinfoforsystem="
Printer Information:
Printers connected: $printerinfo
"
# Getting the output using the script
if [ "$nullmode" = "yes" -o "$domaindetailofhost" = "yes" ]; then
  echo "$hostnameinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$IPaddressofhost" = "yes" ]; then
  echo "$ipaddressinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$CPUinfoofhost" = "yes" ]; then
  echo "$CPUinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$memorydetailofhost" = "yes" ]; then
  echo "$RAMinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$operatingsystemdetailsofhost" = "yes" ]; then
  echo "$OSinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$Operatingsystemversionofhost" = "yes" ]; then
  echo "$OSversioninfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$diskspacedetailsofhost" = "yes" ]; then
  echo "$Diskspaceinfoforsystem"
fi

if [ "$nullmode" = "yes" -o "$printerdetailsofhost" = "yes" ]; then
  echo "$Printerinfoforsystem"
fi

#   END OF THE SCRIPT
