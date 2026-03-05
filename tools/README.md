# Project Creation Tools

Automated tools to streamline creating new build projects.

## Quick Start

**Recommended: Use the interactive tool**

```bash
./tools/create-project-interactive.sh
```

This will walk you through all steps:
- Project details (title, description, category)
- YouTube video (optional)
- Image optimization and copying
- Creates properly formatted markdown file

---

## Tools Overview

### 1. Interactive Project Creator

**Most user-friendly option** - prompts for all information.

```bash
./tools/create-project-interactive.sh
```

**What it does:**
- Asks for project details
- Validates input
- Extracts YouTube ID from URL
- Optimizes images automatically
- Creates properly formatted markdown file
- Opens in your editor

**Example walkthrough:**
```
Project URL slug: lift-kit-installation
Project title: 3-Inch Lift Kit Installation
Short description: Complete suspension upgrade for better ground clearance
Category: Suspension
Difficulty: Advanced
Project date: 2024-03-15
YouTube URL: https://www.youtube.com/watch?v=ptKyAY0qIQM
Do you have images ready? y
Path to folder: ~/Desktop/LiftKitPhotos
```

### 2. Image Optimizer

Batch process and optimize images for web.

```bash
./tools/optimize-images.sh project-slug /path/to/photos
```

**Example:**
```bash
./tools/optimize-images.sh roof-rack ~/Photos/RoofRack
```

**What it does:**
- Resizes images to max 1920px wide
- Compresses to 85% quality (good balance)
- Strips metadata (reduces file size)
- Converts to progressive JPEG (faster loading)
- Shows size savings

**Requirements:**
- ImageMagick (auto-installs on macOS with Homebrew)

### 3. Basic Project Creator

Quick file creation without interactive prompts.

```bash
./add-project.sh "project-slug"
```

Simple script that just creates the markdown file from template.

---

## Recommended Workflow

### For a New Project:

1. **Gather your materials:**
   - Photos from the build (phone, camera, screenshots)
   - YouTube video URL (if you have one)
   - Notes about the project

2. **Organize photos in a folder:**
   ```
   ~/Desktop/MyProject/
   ├── IMG_001.jpg (truck before)
   ├── IMG_002.jpg (parts)
   ├── IMG_003.jpg (installation)
   ├── IMG_004.jpg (finished)
   └── IMG_005.jpg (testing)
   ```

3. **Run interactive creator:**
   ```bash
   ./tools/create-project-interactive.sh
   ```

4. **Edit the generated file:**
   - Replace placeholder text
   - Organize images (rename to descriptive names)
   - Add your story and details

5. **Preview locally:**
   ```bash
   npm run dev
   ```
   Visit: http://localhost:4321/projects/your-slug

6. **Publish:**
   ```bash
   git add .
   git commit -m "Add project: Project Name"
   git push
   ```

---

## Image Best Practices

### Recommended Structure

Organize by project:
```
public/assets/images/projects/
├── lift-kit-installation/
│   ├── hero.jpg (featured image)
│   ├── planning.jpg
│   ├── parts.jpg
│   ├── install-1.jpg
│   ├── install-2.jpg
│   ├── install-3.jpg
│   └── results.jpg
└── roof-rack-build/
    ├── hero.jpg
    └── ...
```

### Naming Convention

Use descriptive names that match content:

✅ **Good:**
- `hero.jpg` - Main featured image
- `parts-laid-out.jpg`
- `install-front-shock.jpg`
- `install-rear-spring.jpg`
- `results-clearance.jpg`

❌ **Avoid:**
- `IMG_1234.jpg`
- `Photo1.jpg`
- `Untitled.jpg`

### Image Sizes

- **Hero images:** 1920x1080px or 1280x720px (16:9 ratio)
- **Content images:** 1200-1920px wide
- **File size:** < 500KB ideal (optimizer handles this)

### Taking Good Project Photos

**Do:**
- Good lighting (natural daylight best)
- Clear focus on the subject
- Show context (not just close-ups)
- Before/after comparisons
- Process steps in order
- Clean workspace

**Don't:**
- Dark/shadowy photos
- Blurry images
- Cluttered backgrounds
- Only close-ups (show overall view too)

---

## Markdown Formatting Tips

### Headers

```markdown
## Main Section (H2)
### Subsection (H3)
#### Detail (H4) - rarely needed
```

### Images

```markdown
![Descriptive alt text](/assets/images/projects/slug/image.jpg)
```

**Pro tip:** Add image captions by using the alt text:
```markdown
![Front suspension before installation showing worn bushings](/assets/images/...)
```

### Lists

**Bulleted:**
```markdown
- Item 1
- Item 2
- Item 3
```

**Numbered:**
```markdown
1. First step
2. Second step
3. Third step
```

### Emphasis

```markdown
**Bold text** for important points
*Italic text* for emphasis
```

### Links

```markdown
[Link text](https://url.com)
[Internal link](/projects/other-project)
```

### Callouts

Use quote blocks for important notes:
```markdown
> **⚠️ Safety Warning:** Always use jack stands, never work under a vehicle supported only by a jack.
```

### Tables (for comparisons)

```markdown
| Part | Before | After |
|------|--------|-------|
| Ground Clearance | 8.5" | 11.5" |
| Approach Angle | 28° | 32° |
```

---

## VS Code Extensions (Recommended)

If you use VS Code, install these for better experience:

1. **Markdown All in One**
   - Preview markdown as you type
   - Keyboard shortcuts
   - Auto-formatting

2. **Markdown Paste**
   - Paste images directly from clipboard
   - Auto-copies to assets folder

3. **markdownlint**
   - Checks markdown formatting
   - Enforces consistent style

4. **Image Preview**
   - Shows image thumbnails in sidebar
   - Preview images on hover

Install via VS Code:
```
Cmd+Shift+P → "Extensions: Install Extensions" → Search for extension name
```

---

## Offline Markdown Editors

If you prefer dedicated editors:

### macOS:
- **MacDown** (free) - Live preview, simple
- **Typora** (paid) - WYSIWYG, beautiful
- **iA Writer** (paid) - Minimal, focused

### Cross-platform:
- **Mark Text** (free) - Clean, modern
- **Obsidian** (free) - Powerful, feature-rich
- **Notable** (free) - Tags, organization

### Just use what you have:
- VS Code (you probably already have it)
- Any text editor (TextEdit, Sublime, Atom)
- Even Notes app works!

---

## Troubleshooting

### ImageMagick not installing?

**macOS:**
```bash
# Install Homebrew first (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install ImageMagick
brew install imagemagick
```

**Skip optimization:**
Just copy images manually to `public/assets/images/projects/` - the optimizer is optional.

### Script won't run?

Make executable:
```bash
chmod +x tools/create-project-interactive.sh
chmod +x tools/optimize-images.sh
```

### Images not showing in preview?

- Check path starts with `/assets/...`
- Check file actually exists
- Check filename matches exactly (case-sensitive)
- Restart dev server

### Can't extract YouTube ID?

Just use the video ID directly:
```yaml
youtubeId: "dQw4w9WgXcQ"
```

Get from URL: `https://youtube.com/watch?v=dQw4w9WgXcQ`
                                              ^^^^^^^^^^^

---

## Advanced: Bulk Operations

### Rename multiple images at once

```bash
cd public/assets/images/projects/my-project

# Rename with pattern
for i in *.jpg; do
    mv "$i" "my-project-$(printf '%02d' $((++count))).jpg"
done
```

### Batch optimize existing images

```bash
# Optimize all projects
for project in public/assets/images/projects/*/; do
    project_name=$(basename "$project")
    ./tools/optimize-images.sh "$project_name" "$project"
done
```

### Generate image list for markdown

```bash
cd public/assets/images/projects/my-project
for img in *.jpg; do
    echo "![Description](/assets/images/projects/my-project/$img)"
done
```

---

## Template Customization

Want to change the project template?

Edit: `new-project-template.md`

This is used by:
- `add-project.sh` (copies it directly)
- `create-project-interactive.sh` (generates from it)

Make your changes once, all new projects use the updated template.

---

## Getting Help

- **Template:** `new-project-template.md`
- **Example:** `src/content/projects/lift-kit-installation.md`
- **Full docs:** `PROJECT-GUIDE.md`
- **Quick ref:** `QUICK-START.md`

---

## Pro Tips

1. **Start with your photos first** - having images helps you write better descriptions

2. **Use the interactive tool** - it handles all the tedious parts

3. **Keep a "Projects In Progress" folder** - dump photos there as you work, organize later

4. **Screenshot your YouTube video** - if you need more images, grab frames from your video

5. **Write as you build** - take notes during the project, easier than remembering later

6. **Don't overthink it** - publish and improve later, perfect is the enemy of done

7. **Reuse structure** - once you have one good project, copy its markdown structure

8. **Preview often** - run `npm run dev` and keep it open while editing
