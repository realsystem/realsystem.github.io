#!/bin/bash

# Script to create a new project from template
# Usage: ./add-project.sh "project-slug"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ -z "$1" ]; then
  echo -e "${YELLOW}Usage: ./add-project.sh \"project-slug\"${NC}"
  echo "Example: ./add-project.sh \"roof-rack-build\""
  exit 1
fi

PROJECT_SLUG="$1"
PROJECT_DIR="src/content/projects"
PROJECT_FILE="${PROJECT_DIR}/${PROJECT_SLUG}.md"

# Check if project already exists
if [ -f "$PROJECT_FILE" ]; then
  echo -e "${YELLOW}Project '${PROJECT_SLUG}' already exists!${NC}"
  exit 1
fi

# Create the project file from template
cp new-project-template.md "$PROJECT_FILE"

echo -e "${GREEN}✓ Created new project: ${PROJECT_FILE}${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Edit ${PROJECT_FILE}"
echo "2. Update the frontmatter (title, description, date, etc.)"
echo "3. Add your content (text, images, tips)"
echo "4. Add images to public/assets/images/projects/"
echo "5. Run 'npm run dev' to preview"
echo ""
echo -e "${GREEN}Opening file in your default editor...${NC}"

# Try to open in VS Code, otherwise default editor
if command -v code &> /dev/null; then
  code "$PROJECT_FILE"
elif command -v nano &> /dev/null; then
  nano "$PROJECT_FILE"
else
  echo "Please manually edit: $PROJECT_FILE"
fi
