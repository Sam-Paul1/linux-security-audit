
#!/bin/bash
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
RESET='\e[0m'

ex(){
printf "%-13b   :%b\n" "$1" "$2"
}
echo "===================================="
echo "         Linux Security Audit       "
echo "===================================="
ex "Date" "$(date +%d-%m-%Y)"
ex "Time"    "$(date +%H:%M:%S)"
ex "Hostname"    " $(hostname)"
echo "=========SYSTEM INFORMATION========="
ex "Current User" "$(whoami) "
ex "OS"          "$(grep "PRETTY_NAME" /etc/os-release|cut -d'"' -f2)"
ex "Kernel"      "$(uname -r)"
ex "Uptime"      "$(uptime -p)"
echo "=========NETWORK INFORMATION========="
ex "IP Address"      "$(hostname -I|cut -d' ' -f1)"
ex "Default Gateway" "$( ip route|grep "default" |awk '{print $3}')"
ex "DNS Server"      "$(grep "nameserver" /etc/resolv.conf |cut -d' ' -f2)"
echo "=========SECURITY INFORMATION========="

uid=$(id -u)
if [ $uid -eq 0 ]; then
        y=$(ufw status|awk '{print $2}')
        if [ "$y" = "active" ]; then
                ex "Firewall Status" "${GREEN}ACTIVE${RESET}"
        else
                ex "FIREWALL STATUS" "${RED}INACTIVE${RESET}"
        fi
else
        ex "FIREWALL STATUS" "${YELLOW}UNKNOWN(require's root)${RESET}"
fi

ex "Listening Ports" "$(ss -tln|grep "LISTEN"|wc -l)"
echo "PORTS"
port=$(ss -tln|awk 'NR>1 {print $5}'|cut -d ':' -f2)


for i in $port
do
d=$(grep -w "${i}/tcp" /etc/services|awk '{print $1}')

        if [ -z "$d" ]; then
                ex "$i" "${YELLOW}UNKNOWN${RESET}"
        else
                ex "$i" "${GREEN}$d${RESET}"
        fi
done


ex "RUNNING PROCESSES" "$(ps|awk 'NR>1'|wc -l)"

ex "LOGGED IN USERS" "$(who|wc -l)"
echo "------Current Sessions------"
echo "$(who)\n"

memory=$(free -h)
ex "RAM USAGE" "$(echo "$memory"|awk '$1 == "Mem:" {print $3}')/$(echo "$memory"|awk '$1 == "Mem:" {print $2}')"

disc=$(df -h)
ex "DISK USAGE" "$(echo "$disc"|awk '$NF == "/" {print $3,"/",$2,"("$5")"}')"
ssh=$(systemctl is-active ssh)

if [ "$ssh" = "active" ];then
ex "SSH STATUS" "${GREEN}ACTIVE${RESET}"
elif [ "$ssh" = "inactive" ];then

ex "SSH STATUS" "${RED}INACTIVE${RESET}"
else
ex "SSH STATUS" "${YELLOW}UNKNOWN${RESET}"
fi


echo "=============SUMMARY============="

# Firewall
if [ "$uid" -eq 0 ]; then
    if [ "$y" = "active" ]; then
        ex "Firewall" "${GREEN}OK${RESET}"
    else
        ex "Firewall" "${RED}WARNING${RESET}"
    fi
else
    ex "Firewall" "${YELLOW}UNKNOWN${RESET}"
fi

# SSH
if [ "$ssh" = "active" ]; then
    ex "SSH" "${GREEN}OK${RESET}"
else
    ex "SSH" "${RED}WARNING${RESET}"
fi

# Listening Ports
port_count=$(echo "$port" | wc -w)
if [ "$port_count" -eq 0 ]; then
    ex "Listening Ports" "${GREEN}OK (0)${RESET}"
else
    ex "Listening Ports" "${YELLOW}WARNING ($port_count)${RESET}"
fi

# Disk Usage
disk_percent=$(echo "$disc" | awk '$NF == "/" {gsub("%","",$5); print $5}')

if [ "$disk_percent" -ge 90 ]; then
    ex "Disk Usage" "${RED}CRITICAL (${disk_percent}%)${RESET}"
elif [ "$disk_percent" -ge 80 ]; then
    ex "Disk Usage" "${YELLOW}WARNING (${disk_percent}%)${RESET}"
else
    ex "Disk Usage" "${GREEN}OK (${disk_percent}%)${RESET}"
fi
