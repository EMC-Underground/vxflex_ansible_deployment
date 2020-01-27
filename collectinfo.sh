#!/bin/bash

null_file(){
  > variable_file.yml
}

function valid_ip() {
    local  ip=$1
    local  stat=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

create_list() {
    local array=$1
    list=$(echo $array | xargs -d "," -n1)
    echo "vxflex_tiebreaker_mdm_ip:"
    for i in $list
      do echo "  - $i"
    done
}

get_num_ip() {
    num_ip=$(echo $result|awk -F',' '{print NF}')
    echo "vxflex_tiebreaker_mdm_ip:"
    for i in $list
      do echo "  - $i"
    done
}

ask_question() {
    local question=$1 key=$2 default=$3 result=""
    printf "${magenta}${question} (${default}): ${reset}"
    read result
    if [ "$result" == "" ]; then result=$default; fi
    echo "${key}: ${result}" >> variable_file.yml
}

ask_question_list() {
    local is_ip=0
    local question=$1 key=$2 default=$3 is_ip=$4 ip_count=$5 result=""
    printf "${magenta}${question} (${default}): ${reset}"
    read result
    if [ "$result" == "" ]; then result=$default; else create_list "$result"; fi
    echo "${key}: ${result}" >> variable_file.yml
}

null_file
ask_question_list "Enter master MDM storage IP address" "vxflex_tiebreaker_mdm_ip" ""
ask_question "Enter NTP Server" "ntp_server" "0.us.pool.ntp.org"
ask_question "Enter Enter Gatway Server IP address" "vxflex_gateway_ip" ""
ask_question "Enter Gateway Username" "vxflex_gateway_username" "admin"
ask_question "Enter Gateway Password" "vxflex_gateway_pw" "Password#1"
ask_question "Enter Gateway http port" "vxflex_gateway_http_port" "8080"
ask_question "Enter Gateway https port" "vxflex_gateway_https_port" "8443"
ask_question "Enter vxflex version" "vxflex_version" "2.6-10000.123"
ask_question "Enter system name" "vxflex_system_name" "scaleio"
ask_question "Enter protection domain name" "vxflex_protection_domain_name" "pd1"
ask_question "Enter storage pool name" "vxflex_storage_pool_name" "sp1"
ask_question "Enter master MDM name" "vxflex_master_mdm_name" "scaleio-node0"
ask_question "Enter standby MDM name" "vxflex_standby_mdm_name" "scaleio-node1"
ask_question "Enter tiebreaker MDM name" "vxflex_tiebreaker_mdm_name" "scaleio-node2"
ask_question "Enter cluster VIP IP address" "vxflex_vip_ip" ""
ask_question "Enter master MDM managemnt IP address" "vxflex_master_mdm_mgmt_ip" ""
ask_question "Enter standby MDM managemnt IP address" "vxflex_standby_mdm_mgmt_ip" ""
ask_question "Enter tiebreaker MDM management IP address" "vxflex_tiebreaker_mdm_mgmt_ip" ""
ask_question "Enter master MDM storage IP address" "vxflex_tiebreaker_mdm_ip" ""
ask_question "Enter standby MDM storage IP address" "vxflex_tiebreaker_mdm_ip" ""
ask_question "Enter tiebreaker MDM storage IP address" "vxflex_tiebreaker_mdm_ip" ""
ask_question "Enter storage network with subnet" "vxflex_mdm_cidr" "192.168.0.0/8"
ask_question "Enter rexray log level" "rexray_log_level" "debug"


