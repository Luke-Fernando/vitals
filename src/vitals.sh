#!/bin/bash

VERSION="1.0.0"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

CHECK_MARK="\xE2\x9C\x94"
X_MARK="\xE2\x9C\x98"
WARN_SIGN="\xE2\x9A\xA0"

show_banner() {
    printf "%b%b" "$CYAN" "$BOLD"
    cat << "EOF"
 __      _______ _______       _       _____
 \ \    / /_   _|__   __|     | |     / ____|
  \ \  / /  | |    | |   __ _ | | ___| (___
   \ \/ /   | |    | |  / _` || |/ __|\___ \
    \  /   _| |_   | | | (_| || |\__ \____) |
     \/   |_____|  |_|  \__,_||_||___/_____/
EOF
    printf "          v%s - Website Health Monitor\n" "$VERSION"
    printf "%b\n" "$NC"
}

show_help() {
    cat << EOF
Usage: vitals [OPTION] [URL/FILE]

A lightweight tool to check website health and response times.

Options:
  -h, --help     Show this help message
  -v, --version  Show version information

Examples:
  vitals google.com
  vitals ./sites_list.txt
EOF
}

if ! command -v curl >/dev/null 2>&1; then
    printf "%bError: 'curl' is not installed. Please install it to use Vitals.%b\n" "$RED" "$NC"
    exit 1
fi

check_url() {
    local target="$1"
    [[ ! $target =~ ^https?:// ]] && target="https://$target"
    
    response=$(curl -s -o /dev/null -L -w "%{http_code} %{time_total}" --connect-timeout 5 "$target")
    status_code=$(echo "$response" | cut -d' ' -f1)
    latency=$(echo "$response" | cut -d' ' -f2)
    
    if [[ "$status_code" -ge 200 && "$status_code" -lt 300 ]]; then
        COLOR=$GREEN
        ICON=$CHECK_MARK
        LABEL="OK"
        elif [[ "$status_code" -eq 000 || "$status_code" -ge 400 ]]; then
        COLOR=$RED
        ICON=$X_MARK
        LABEL="FAIL"
    else
        COLOR=$YELLOW
        ICON=$WARN_SIGN
        LABEL="WARN"
    fi
    
    printf "${COLOR}%b %-5s${NC} │ %-35s │ ${BOLD}%-3s${NC} │ %.6fs\n" "$ICON" "$LABEL" "$target" "$status_code" "$latency"
}

if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
    printf "%bVitals version %b%s%b\n" "$CYAN" "$BOLD" "$VERSION" "$NC"
    exit 0
fi

show_banner

# Table Header
printf "${BOLD}%-7s │ %-35s │ %-3s │ %-6s${NC}\n" "STATUS" "TARGET URL" "COD" "TIME"
echo "────────┼─────────────────────────────────────┼─────┼──────────"

if [[ -f "$1" ]]; then
    while IFS= read -r line; do
        [[ -n "$line" ]] && check_url "$line"
    done < "$1"
else
    check_url "$1"
fi

echo "────────┴─────────────────────────────────────┴─────┴──────────"
printf "%bFinished check at %s%b\n\n" "$BLUE" "$(date +'%H:%M:%S')" "$NC"