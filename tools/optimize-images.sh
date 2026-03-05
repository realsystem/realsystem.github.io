#!/bin/bash

# Image Optimization Script for Projects
# Automatically resizes and optimizes images for web

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Project Image Optimizer ===${NC}\n"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo -e "${YELLOW}ImageMagick not found. Installing...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install imagemagick
        else
            echo -e "${YELLOW}Please install Homebrew first: https://brew.sh${NC}"
            exit 1
        fi
    else
        echo "Please install ImageMagick manually"
        exit 1
    fi
fi

# Get project name
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./optimize-images.sh project-slug source-folder${NC}"
    echo "Example: ./optimize-images.sh roof-rack ~/Photos/RoofRack"
    exit 1
fi

PROJECT_SLUG="$1"
SOURCE_DIR="$2"
OUTPUT_DIR="public/assets/images/projects/${PROJECT_SLUG}"

if [ -z "$SOURCE_DIR" ]; then
    echo -e "${YELLOW}Please specify source folder${NC}"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${YELLOW}Source directory not found: $SOURCE_DIR${NC}"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}Processing images for project: ${PROJECT_SLUG}${NC}"
echo -e "Source: ${SOURCE_DIR}"
echo -e "Output: ${OUTPUT_DIR}\n"

# Process each image
count=0
for img in "$SOURCE_DIR"/*.{jpg,jpeg,JPG,JPEG,png,PNG} 2>/dev/null; do
    [ -f "$img" ] || continue

    filename=$(basename "$img")
    name="${filename%.*}"
    ext="${filename##*.}"

    # Convert to lowercase jpg
    output="${OUTPUT_DIR}/${name,,}.jpg"

    echo -e "${BLUE}Processing: ${filename}${NC}"

    # Get original dimensions
    original_size=$(identify -format "%wx%h" "$img")

    # Resize and optimize
    # - Max width 1920px
    # - Quality 85%
    # - Strip metadata
    # - Progressive JPEG
    convert "$img" \
        -resize '1920x1920>' \
        -quality 85 \
        -strip \
        -interlace Plane \
        "$output"

    new_size=$(identify -format "%wx%h" "$output")
    original_bytes=$(stat -f%z "$img" 2>/dev/null || stat -c%s "$img")
    new_bytes=$(stat -f%z "$output" 2>/dev/null || stat -c%s "$output")

    # Calculate savings
    savings=$((100 - (new_bytes * 100 / original_bytes)))

    echo -e "  ${GREEN}✓${NC} ${original_size} → ${new_size}"
    echo -e "  ${GREEN}✓${NC} $(numfmt --to=iec-i --suffix=B $original_bytes) → $(numfmt --to=iec-i --suffix=B $new_bytes) (${savings}% smaller)"
    echo ""

    ((count++))
done

if [ $count -eq 0 ]; then
    echo -e "${YELLOW}No images found in $SOURCE_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Processed $count images${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Review images in: $OUTPUT_DIR"
echo "2. Rename them descriptively:"
echo "   - hero.jpg (main/featured image)"
echo "   - planning.jpg, parts.jpg, install-1.jpg, install-2.jpg, results.jpg"
echo "3. Reference in markdown: ![Description](/assets/images/projects/${PROJECT_SLUG}/hero.jpg)"
