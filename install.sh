#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "Installing vitals..."

if [ ! -f "src/vitals.sh" ]; then
    echo -e "${RED}Error: src/vitals.sh not found!${NC}"
    exit 1
fi

chmod +x src/vitals.sh

if sudo cp src/vitals.sh /usr/local/bin/vitals; then
    echo -e "${GREEN}Vitals installed successfully!${NC}"
else
    echo -e "${RED}Error: Failed to install vitals!${NC}"
    exit 1
fi