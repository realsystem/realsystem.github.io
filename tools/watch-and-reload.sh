#!/bin/bash

# Watch for changes and auto-rebuild
# Useful when editing projects

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting development server with auto-reload...${NC}"
echo -e "${GREEN}Visit: http://localhost:4321${NC}\n"

npm run dev
