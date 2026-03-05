#!/bin/bash

# Interactive Project Creator
# Walks you through creating a new project with all necessary files

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════╗
║   Interactive Project Creator        ║
║   for Overlanding Project Lab        ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}\n"

# Function to prompt for input
prompt() {
    local var_name=$1
    local prompt_text=$2
    local default=$3

    if [ -n "$default" ]; then
        read -p "$(echo -e ${BLUE}${prompt_text}${NC} [${default}]: )" value
        value=${value:-$default}
    else
        read -p "$(echo -e ${BLUE}${prompt_text}${NC}: )" value
    fi

    eval $var_name=\"\$value\"
}

# Step 1: Project slug
echo -e "${YELLOW}Step 1: Project Basics${NC}\n"
prompt PROJECT_SLUG "Project URL slug (e.g., 'lift-kit-installation')"

if [ -z "$PROJECT_SLUG" ]; then
    echo -e "${RED}Project slug is required${NC}"
    exit 1
fi

PROJECT_FILE="src/content/projects/${PROJECT_SLUG}.md"
if [ -f "$PROJECT_FILE" ]; then
    echo -e "${RED}Project '${PROJECT_SLUG}' already exists!${NC}"
    exit 1
fi

# Step 2: Title and description
prompt PROJECT_TITLE "Project title (e.g., '3-Inch Lift Kit Installation')"
prompt PROJECT_DESC "Short description (1-2 sentences)"

# Step 3: Category and difficulty
echo -e "\n${YELLOW}Categories:${NC} Suspension, Armor, Storage, Electrical, Recovery, Camping, Other"
prompt PROJECT_CATEGORY "Category" "Suspension"

echo -e "\n${YELLOW}Difficulty:${NC} Beginner, Intermediate, Advanced"
prompt PROJECT_DIFFICULTY "Difficulty" "Intermediate"

# Step 4: Date
TODAY=$(date +%Y-%m-%d)
prompt PROJECT_DATE "Project date (YYYY-MM-DD)" "$TODAY"

# Step 5: YouTube (optional)
echo -e "\n${YELLOW}YouTube Video (Optional)${NC}"
echo "If you have a YouTube video, paste the full URL or just the video ID"
prompt YOUTUBE_INPUT "YouTube URL or ID (leave empty if none)"

# Extract video ID if URL provided
if [ -n "$YOUTUBE_INPUT" ]; then
    if [[ "$YOUTUBE_INPUT" =~ ^[a-zA-Z0-9_-]{11}$ ]]; then
        YOUTUBE_ID="$YOUTUBE_INPUT"
    elif [[ "$YOUTUBE_INPUT" =~ v=([a-zA-Z0-9_-]{11}) ]]; then
        YOUTUBE_ID="${BASH_REMATCH[1]}"
    elif [[ "$YOUTUBE_INPUT" =~ youtu\.be/([a-zA-Z0-9_-]{11}) ]]; then
        YOUTUBE_ID="${BASH_REMATCH[1]}"
    else
        echo -e "${YELLOW}Could not extract video ID, skipping${NC}"
        YOUTUBE_ID=""
    fi
fi

# Step 6: Images
echo -e "\n${YELLOW}Step 2: Images${NC}\n"
echo "Do you have a folder with project photos?"
prompt HAS_IMAGES "Do you have images ready? (y/n)" "n"

if [[ "$HAS_IMAGES" =~ ^[Yy] ]]; then
    prompt IMAGES_SOURCE "Path to folder containing images"

    if [ -d "$IMAGES_SOURCE" ]; then
        echo -e "${BLUE}I'll optimize and copy your images...${NC}"

        IMG_OUTPUT="public/assets/images/projects/${PROJECT_SLUG}"
        mkdir -p "$IMG_OUTPUT"

        # Check if ImageMagick is available
        if command -v convert &> /dev/null; then
            bash tools/optimize-images.sh "$PROJECT_SLUG" "$IMAGES_SOURCE"
            HERO_IMAGE="/assets/images/projects/${PROJECT_SLUG}/hero.jpg"
        else
            echo -e "${YELLOW}ImageMagick not found. Copying images without optimization...${NC}"
            cp "$IMAGES_SOURCE"/* "$IMG_OUTPUT/"
            HERO_IMAGE="/assets/images/projects/${PROJECT_SLUG}/$(ls $IMG_OUTPUT | head -1)"
        fi
    else
        echo -e "${YELLOW}Directory not found. You can add images later.${NC}"
        HERO_IMAGE="/assets/images/projects/${PROJECT_SLUG}/hero.jpg"
    fi
else
    HERO_IMAGE="/assets/images/projects/${PROJECT_SLUG}/hero.jpg"
    echo -e "${YELLOW}Remember to add images to: public/assets/images/projects/${PROJECT_SLUG}/${NC}"
fi

# Step 7: Create the project file
echo -e "\n${YELLOW}Step 3: Creating Project File${NC}\n"

cat > "$PROJECT_FILE" << EOF
---
title: "${PROJECT_TITLE}"
description: "${PROJECT_DESC}"
date: "${PROJECT_DATE}"
category: "${PROJECT_CATEGORY}"
difficulty: "${PROJECT_DIFFICULTY}"
heroImage: "${HERO_IMAGE}"
EOF

if [ -n "$YOUTUBE_ID" ]; then
    echo "youtubeId: \"${YOUTUBE_ID}\"" >> "$PROJECT_FILE"
fi

cat >> "$PROJECT_FILE" << 'EOF'
featured: false
tags: []
---

## Introduction

Brief introduction to why you did this project and what it accomplishes.

![Hero shot](HERO_IMAGE_PATH)

## Planning and Research

What research did you do? What options did you consider? Why did you choose this approach?

## Parts and Tools

**Tools needed:**
- Tool 1
- Tool 2
- Tool 3

**Parts used:**
- Part 1 (brand, model, part number)
- Part 2
- Part 3

**Total cost:** $XXX

![Parts laid out](IMAGE_PATH)

## Installation Process

Step-by-step description of what you did.

### Step 1: Preparation
Details about this step...

![Photo of step 1](IMAGE_PATH)

### Step 2: Main Work
Details about this step...

![Photo of step 2](IMAGE_PATH)

### Step 3: Final Assembly
Details about this step...

![Photo of step 3](IMAGE_PATH)

## Results and Testing

What was the outcome? How does it perform? What difference did it make?

**Before/After:**
- Measurement 1: Before → After
- Measurement 2: Before → After

![Final result](IMAGE_PATH)

## Challenges and Solutions

What problems did you encounter? How did you solve them?

- **Challenge 1:** Description of problem and solution
- **Challenge 2:** Description of problem and solution

## Pro Tips

Things you learned that would help others:

- Tip 1: Specific advice
- Tip 2: What to watch out for
- Tip 3: Better approach discovered
- Tip 4: Cost-saving idea

## Conclusion

Final thoughts and recommendations. Would you do it again? What would you change?

**Project Stats:**
- **Total Time:** X hours over Y days
- **Difficulty:** X/10
- **Cost:** $XXX
- **Worth it?** Yes/No and why

## Additional Resources

- [Link to parts](#)
- [Reference article](#)
- [Related video](#)
EOF

# Replace HERO_IMAGE_PATH placeholder
sed -i.bak "s|HERO_IMAGE_PATH|${HERO_IMAGE}|g" "$PROJECT_FILE"
rm "${PROJECT_FILE}.bak"

echo -e "${GREEN}✓ Created: ${PROJECT_FILE}${NC}\n"

# Summary
echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Project Created! ✓           ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}\n"

echo -e "${GREEN}Project Details:${NC}"
echo -e "  Title: ${PROJECT_TITLE}"
echo -e "  Slug: ${PROJECT_SLUG}"
echo -e "  Category: ${PROJECT_CATEGORY}"
echo -e "  Difficulty: ${PROJECT_DIFFICULTY}"
if [ -n "$YOUTUBE_ID" ]; then
    echo -e "  Video: https://youtube.com/watch?v=${YOUTUBE_ID}"
fi
echo ""

echo -e "${BLUE}Next Steps:${NC}"
echo -e "1. ${YELLOW}Edit content:${NC} $PROJECT_FILE"
echo -e "2. ${YELLOW}Add/organize images:${NC} public/assets/images/projects/${PROJECT_SLUG}/"
echo -e "3. ${YELLOW}Preview:${NC} npm run dev → http://localhost:4321/projects/${PROJECT_SLUG}"
echo -e "4. ${YELLOW}Publish:${NC} git add . && git commit -m 'Add project: ${PROJECT_TITLE}' && git push"
echo ""

# Offer to open in editor
prompt OPEN_EDITOR "Open in editor now? (y/n)" "y"
if [[ "$OPEN_EDITOR" =~ ^[Yy] ]]; then
    if command -v code &> /dev/null; then
        code "$PROJECT_FILE"
    elif command -v nano &> /dev/null; then
        nano "$PROJECT_FILE"
    else
        echo "Please manually edit: $PROJECT_FILE"
    fi
fi
EOF

chmod +x /Users/segorov/Projects/realsystem.github.io/tools/optimize-images.sh
chmod +x /Users/segorov/Projects/realsystem.github.io/tools/create-project-interactive.sh
