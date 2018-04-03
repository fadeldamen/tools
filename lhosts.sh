#!/bin/bash

####################
# Developed by Luiz Felipe
# - https://github.com/Silva97
####################

help(){
    echo    "Use: ./lhosts.sh ip_range"
    echo -e "\t\x1B[1mip_range\x1B[0m follow the CIDR notation, example: 192.168.0.0/8\n"
    echo    "Developed by Luiz Felipe."
    echo    "For more informations, see:"
    echo -e "\thttps://github.com/Silva97/tools/"
}

error(){
    echo -e "\x1B[31;1mERROR:\x1B[0m ${1}"
}

finish(){
    erase
    echo -e "Finish."
    exit
}

erase(){
    printf "\r%50c\r" " "
}

if [[ $# -eq 0 ]] || [[ "${1:0:2}" -eq "-h" ]]; then
    help
    exit
fi

bits=$(echo -n "$1" | grep -Eo "\/(8|12|16|24)$")
ip=($(echo  -n "${1:0:${#1}-${#bits}}" | sed "y/\./ /"))

if [[ "${#bits}" -eq "0" ]]; then
    error "Input format not correctly."
    help
    exit
fi

bits=${bits:1}

if [[ ${ip[0]} -gt 255 ]] || [[ ${ip[1]} -gt 255 ]] || \
   [[ ${ip[2]} -gt 255 ]] || [[ ${ip[3]} -gt 255 ]]; then
    error "IP range not valid."
    exit
fi

if [[ $bits -eq 12 ]] && [[ ${ip[1]} -gt 31 ]]; then
    error "IP range not valid."
    exit
fi

while true; do
    host="${ip[0]}.${ip[1]}.${ip[2]}.${ip[3]}"
    res=$(ping -i 0.2 -w1 -c1 ${host} 2>/dev/null | grep -Eo "ttl=[0-9]+")

    erase
    echo -ne "Checking ${host}..."
    if [[ "${#res}" -ne "" ]]; then
        if [[ ${res:4} -le 64 ]]; then
            os=Linux
        elif [[ ${res:4} -le 128 ]]; then
            os=Windows
        else
            os=UNIX
        fi

        erase
        echo -e "Host ${host}\t- \x1B[32;1m${os}\x1B[0m"
    fi

    # 0.0.0.x
    ip[3]=$(( ${ip[3]} + 1 ))
    if [[ ${ip[3]} -gt 255 ]]; then
        if [[ "${bits}" -eq "8" ]]; then
            finish
        fi

        ip[2]=$(( ${ip[2]} + 1 ))
        ip[3]="0"
    fi

    # 0.0.x.0
    if [[ ${ip[2]} -gt 255 ]]; then
        if [[ $bits -lt 24 ]]; then
            finish
        fi

        ip[1]=$(( ${ip[1]} + 1 ))
        ip[2]="0"
    fi

    # 0.x.0.0
    if [[ ${ip[1]} -gt 255 ]]; then
        finish
    fi
done