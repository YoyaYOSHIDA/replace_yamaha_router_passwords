#!/bin/bash
#title           : replace_yamaha_router_passwords.sh
#description     : Replaces password strings to dummies for security reasons
#                  to maintain configurations of Yamaha router such as RTX1210 on Git.
#arg ${1}        : <config_before_replacing.txt>
#author          : YoyaYOSHIDA(https://github.com/YoyaYOSHIDA)
#usage           : Execute manually.
#notes           : -
#==============================================================================

FILENAME=${1}
OLDIFS=${IFS}

cat ${FILENAME} | while IFS= read line
do
    if echo "${line}" | grep "pp auth username" > /dev/null 2>&1; then
        echo "${line}" | \
        awk '
          {
            SINGLE_SPACE = " "
            gsub( ".*", "xxxxxxxx", $5 )
            print SINGLE_SPACE $1, $2, $3, $4, $5
          }
        '

    elif echo "${line}" | grep "ipsec ike pre-shared-key" | grep "text" > /dev/null 2>&1; then
        echo "${line}" | \
        awk '
          {
            DOUBLE_SPACE = "  "
            gsub( ".*", "xxxxxxxx", $6 )
            print DOUBLE_SPACE $1, $2, $3, $4, $5, $6
          }
        '

    elif echo "${line}" | grep "pp auth myname" > /dev/null 2>&1; then
        echo "${line}" | \
        awk '
          {
            SINGLE_SPACE = " "
            gsub( ".*", "xxxxxxxx", $5 )
            print SINGLE_SPACE $1, $2, $3, $4, $5
          }
        '

    elif echo "${line}" | grep -e "^radius secret" > /dev/null 2>&1; then
         echo "${line}" | awk '{print $1" "$2" ""xxxxxxxx"}'

    elif echo "${line}" | grep -e "^cloud vpn parameter" > /dev/null 2>&1; then
        echo "${line}" | awk '{print $1" "$2" "$3" "$4" ""xxxxxxxx"}'

    else    
        echo "${line}"
    fi
done

IFS=${OLDIFS}

