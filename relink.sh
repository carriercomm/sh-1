#!/bin/bash

#Script Name:	relink
#Date:		Fri Dec 15 22:47:58 CST 2006
#AUTHOR:	xiaoranzzz


# COLOR
NOR="\033[0m"
BOLD="\033[1m"
RED="\033[91m"
YEL="\033[93m"
GRE="\033[92m"



APPNAME="relink"
APPVER="0.1"
APPDESC="relink the symbol link"
APPUSAGE="(filename) (Pattern) (Replacement)"
EXAMPLE="relink /usr/local/test bin shellscript"


ARGS=$*

if [ -z "$ARGS" ] || [ "$ARGS" = "-h" ] ;then
	echo "$APPNAME V$APPVER"
	echo -e "\t $APPDESC"
	echo -e " -h\tDisplay this."
	echo -e " -e\tWhere am I." 
	echo -e "Usage: $0 $APPUSAGE"
	if [ ! -z "$EXAMPLE" ];then 
	    echo -e "Example: $EXAMPLE"
	fi
	exit 0
fi

if [ "$1" = "-e" ] ; then
    echo $0
    exit 0
fi

FILENAME=`fullname "$1"`
PATTERN=$2
REPLACEMENT=$3

if [ -z "$PATTERN" ] ; then
    echo -e "Usage: $0 $APPUSAGE"
    exit 0
fi

OLDLINK=`linkwhere "$FILENAME"`

if [ -z "$OLDLINK" ] ; then
    exit 0
fi

NEWLINK=`echo "$OLDLINK" | sed "s/$PATTERN/$REPLACEMENT/g"`

if [ "$OLDLINK" == "$NEWLINK" ] ; then
    echo "Nothing to do."
    exit 0
fi

echo "Attemping to change the symbol link"
echo -e "File:\t $FILENAME"
echo -e "From:\t $OLDLINK"
echo -e "To:\t $NEWLINK"

if [ ! -f "$NEWLINK" ]; then
    echo "$NEWLINK not existed."
    echo "Relink ternimated."
    exit -1
fi

sudo ln -sf "$NEWLINK" "$FILENAME"

if [ $? == 0 ]; then
    echo "Successed."
    exit 0
else
    echo "Failed."
    exit -1
fi


