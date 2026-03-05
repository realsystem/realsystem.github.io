#!/bin/bash

# List all projects with details

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== Your Build Projects ===${NC}\n"

count=0
for project in src/content/projects/*.md; do
    [ -f "$project" ] || continue

    slug=$(basename "$project" .md)
    title=$(grep "^title:" "$project" | cut -d'"' -f2)
    category=$(grep "^category:" "$project" | cut -d'"' -f2)
    date=$(grep "^date:" "$project" | cut -d'"' -f2)

    ((count++))

    echo -e "${GREEN}${count}. ${title}${NC}"
    echo -e "   Slug: ${slug}"
    echo -e "   Category: ${category}"
    echo -e "   Date: ${date}"
    echo -e "   File: ${project}"
    echo -e "   URL: /projects/${slug}"
    echo ""
done

if [ $count -eq 0 ]; then
    echo -e "${YELLOW}No projects found${NC}"
    echo "Create your first project:"
    echo "  ./tools/create-project-interactive.sh"
else
    echo -e "${BLUE}Total projects: ${count}${NC}"
fi
