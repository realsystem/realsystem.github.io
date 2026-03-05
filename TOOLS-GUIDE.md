# Tools Guide: Easy Project Creation

Complete toolkit for creating, editing, and managing your build projects with minimal effort.

## 🎯 Quick Commands

```bash
# Create new project (recommended - walks you through everything)
./tools/create-project-interactive.sh

# Optimize images for a project
./tools/optimize-images.sh project-slug ~/Photos/MyProject

# List all your projects
./tools/list-projects.sh

# Preview a specific project
./tools/preview-project.sh project-slug

# Start dev server
./tools/watch-and-reload.sh
```

---

## 🚀 Complete Workflow

### Starting a New Project

**1. Take photos during your build**
- Phone photos are fine!
- Just dump them in a folder: `~/Desktop/LiftKitBuild/`
- Don't worry about names yet

**2. Run the interactive creator**
```bash
./tools/create-project-interactive.sh
```

This will:
- ✅ Ask for project details (title, category, etc.)
- ✅ Extract YouTube video ID automatically
- ✅ Optimize all your images
- ✅ Create properly formatted markdown
- ✅ Open in your editor

**3. Fill in the content**
- Replace placeholder text with your story
- Organize images (rename descriptively)
- Add tips you learned

**4. Preview**
```bash
npm run dev
```
Visit: http://localhost:4321/projects/your-slug

**5. Publish**
```bash
git add .
git commit -m "Add project: Project Name"
git push
```

Done! GitHub Actions deploys automatically.

---

## 📸 Image Workflow

### Option 1: Let the tool handle it (easiest)

When running `create-project-interactive.sh`, just point it to your photo folder:
```
Path to folder containing images: ~/Desktop/MyProjectPhotos
```

It automatically:
- Resizes to web-optimal size (1920px max)
- Compresses (85% quality - perfect balance)
- Converts to JPG
- Strips metadata
- Saves 40-70% file size

### Option 2: Manual optimization

```bash
./tools/optimize-images.sh roof-rack ~/Photos/RoofRack
```

This processes all images in the folder and puts optimized versions in:
```
public/assets/images/projects/roof-rack/
```

### Option 3: Just copy images

If you don't want to install ImageMagick:
```bash
cp ~/Photos/MyProject/* public/assets/images/projects/my-project/
```

Works fine, just larger file sizes.

### Organizing Images After Processing

Rename to descriptive names:
```bash
cd public/assets/images/projects/my-project

mv IMG_001.jpg hero.jpg
mv IMG_002.jpg planning.jpg
mv IMG_003.jpg parts-laid-out.jpg
mv IMG_004.jpg install-front.jpg
mv IMG_005.jpg install-rear.jpg
mv IMG_006.jpg results.jpg
```

Or use this pattern:
```bash
mv PXL_20240315_143834.jpg lift-kit-hero.jpg
mv PXL_20240315_152233.jpg lift-kit-parts.jpg
# etc.
```

---

## ✏️ Editing Projects

### VS Code Setup (Recommended)

**1. Install recommended extensions**

Open project in VS Code, it will prompt to install:
- Markdown All in One (preview, shortcuts)
- Markdown Paste (paste images directly)
- markdownlint (style checking)
- Image Preview (see thumbnails)

**2. Use split view**
- Open `.md` file
- Press `Cmd+K V` (Mac) or `Ctrl+K V` (Windows/Linux)
- Edit on left, preview on right

**3. Paste images directly**

With "Paste Image" extension:
1. Copy image (screenshot, photo)
2. Paste in markdown: `Cmd+Alt+V`
3. Automatically saves to projects folder
4. Inserts correct markdown path

### Other Editors

**MacDown (macOS, free):**
- Download: https://macdown.uranusjr.com/
- Live preview built-in
- Simple, focused

**Typora (paid, beautiful):**
- WYSIWYG editing
- What you see is what you get
- Very polished

**Just use any text editor:**
- TextEdit, Notepad, Sublime, Atom
- Markdown is just text!

---

## 🎬 YouTube Integration

### Extract Video ID Automatically

The interactive tool does this for you. Just paste any of these formats:

```
https://www.youtube.com/watch?v=dQw4w9WgXcQ
https://youtu.be/dQw4w9WgXcQ
dQw4w9WgXcQ
```

All extract to: `dQw4w9WgXcQ`

### Manual Method

In your project frontmatter:
```yaml
youtubeId: "dQw4w9WgXcQ"
```

The video automatically embeds at the top of your project page.

### No Video Yet?

Just leave it out of frontmatter. You can add it later:

1. Upload video to YouTube
2. Edit the `.md` file
3. Add `youtubeId: "VIDEO_ID"`
4. Commit and push

---

## 🔧 Advanced Tools

### Batch Rename Images

Rename all images in a project folder with a pattern:

```bash
cd public/assets/images/projects/my-project

# Add project name prefix to all images
for file in *.jpg; do
    mv "$file" "my-project-$file"
done

# Number sequentially
count=0
for file in *.jpg; do
    mv "$file" "my-project-$(printf '%02d' $((++count))).jpg"
done
```

### Extract Frames from Video

If you need more photos, grab them from your YouTube video:

**Using VLC:**
1. Open video in VLC
2. Pause at good frame
3. Video → Take Snapshot
4. Saves to ~/Pictures

**Using ffmpeg:**
```bash
# Install
brew install ffmpeg

# Extract frame at 1:23
ffmpeg -ss 00:01:23 -i video.mp4 -frames:v 1 snapshot.jpg

# Extract frames every 30 seconds
ffmpeg -i video.mp4 -vf fps=1/30 frame-%03d.jpg
```

### Create Thumbnails

Generate smaller preview versions:

```bash
cd public/assets/images/projects/my-project

for img in *.jpg; do
    convert "$img" -resize 400x400 "thumb-$img"
done
```

### Watermark Images

Add your branding:

```bash
for img in *.jpg; do
    convert "$img" \
        -gravity southeast \
        -pointsize 24 \
        -fill white \
        -stroke black \
        -strokewidth 2 \
        -annotate +10+10 "OverlandingProjectLab.com" \
        "watermarked-$img"
done
```

---

## 📋 Project Management

### List All Projects

```bash
./tools/list-projects.sh
```

Shows:
- All projects with titles
- Categories and dates
- File paths and URLs

### Find a Project

```bash
# Search by title
grep -r "Lift Kit" src/content/projects/

# Search by category
grep "category: \"Suspension\"" src/content/projects/*.md

# Find all projects with videos
grep "youtubeId:" src/content/projects/*.md
```

### Update Multiple Projects

```bash
# Add a tag to all suspension projects
for file in src/content/projects/*.md; do
    if grep -q 'category: "Suspension"' "$file"; then
        # Add tag (requires manual editing)
        echo "$file needs suspension tag"
    fi
done
```

---

## 🎨 Styling & Formatting

### Consistent Formatting

Use this structure for all projects:

```markdown
## Introduction (required)
Brief overview of project and why you did it

## Planning (recommended)
Research, options considered, decisions made

## Parts and Tools (recommended)
Lists of what you needed

## Installation/Build Process (required)
Step-by-step what you did

## Results (required)
Outcome, performance, measurements

## Challenges (optional but recommended)
Problems and solutions

## Pro Tips (recommended)
What you learned, advice for others

## Conclusion (required)
Final thoughts, would you do it again

## Additional Resources (optional)
Links to parts, videos, references
```

### Markdown Style Guide

**Headers:**
```markdown
## Main Section (use H2)
### Subsection (use H3)
#### Only if really needed (H4)
```

**Lists:**
```markdown
**Bold list labels:**
- Tool 1: Description
- Tool 2: Description

**Bullet points:**
- Simple item
- Another item

**Numbered steps:**
1. First step
2. Second step
3. Third step
```

**Callouts:**
```markdown
> **⚠️ Safety Warning:** Important safety info

> **💡 Pro Tip:** Helpful advice

> **📝 Note:** Additional information
```

**Formatting:**
```markdown
**Bold** for important terms
*Italic* for emphasis
`code` for part numbers or commands
```

---

## 🐛 Troubleshooting

### Images Not Showing

**Check path format:**
```markdown
✅ /assets/images/projects/my-project/image.jpg
❌ assets/images/projects/my-project/image.jpg
❌ /public/assets/images/projects/my-project/image.jpg
❌ ../../../public/assets/images/projects/my-project/image.jpg
```

**Check file exists:**
```bash
ls public/assets/images/projects/my-project/
```

**Check filename matches exactly** (case-sensitive):
- `Hero.jpg` ≠ `hero.jpg`
- `IMG_1234.JPG` ≠ `IMG_1234.jpg`

### YouTube Not Embedding

**Check frontmatter format:**
```yaml
✅ youtubeId: "dQw4w9WgXcQ"
❌ youtubeId: dQw4w9WgXcQ (missing quotes)
❌ youtubeId: "https://youtube.com/..." (full URL)
❌ youtubeID: "dQw4w9WgXcQ" (capital ID)
```

### Build Errors

**Common issues:**

1. **Missing required field:**
```yaml
# All of these are required:
title: "..."
description: "..."
date: "2024-03-15"
category: "..."
difficulty: "..."
heroImage: "..."
```

2. **Invalid category:**
```yaml
✅ category: "Suspension"
❌ category: "suspension" (wrong case)
❌ category: "Lifts" (not in allowed list)
```

Options: Suspension, Armor, Storage, Electrical, Recovery, Camping, Other

3. **Invalid difficulty:**
```yaml
✅ difficulty: "Intermediate"
❌ difficulty: "Medium"
❌ difficulty: "intermediate"
```

Options: Beginner, Intermediate, Advanced

4. **Date format:**
```yaml
✅ date: "2024-03-15"
❌ date: "March 15, 2024"
❌ date: "03/15/2024"
❌ date: 2024-03-15 (missing quotes)
```

### Scripts Won't Run

**Make executable:**
```bash
chmod +x tools/*.sh
```

**Permission denied:**
```bash
sudo chmod +x tools/*.sh
```

**Command not found:**
```bash
# Run from project root
cd /Users/segorov/Projects/realsystem.github.io
./tools/create-project-interactive.sh
```

---

## ⚡ Tips & Tricks

### 1. Use Draft Mode

Add to frontmatter:
```yaml
featured: false  # Don't show on homepage
```

Work on project privately, change to `true` when ready.

### 2. Reuse Previous Projects

Copy structure from a good project:
```bash
cp src/content/projects/lift-kit.md src/content/projects/new-project.md
# Edit new-project.md, update frontmatter
```

### 3. Preview Before Committing

Always run locally first:
```bash
npm run dev
```

Check:
- Images load
- Video embeds
- Formatting looks good
- Links work

### 4. Screenshot YouTube for Images

Download your own video, extract frames for additional photos.

### 5. Keep a Templates Folder

```
~/ProjectTemplates/
├── photos/
├── notes.txt
└── parts-list.txt
```

Start each new project by filling this folder as you work.

### 6. Batch Process on Sunday

Take photos all week, process all projects on Sunday:
```bash
for dir in ~/Desktop/Projects/*/; do
    project=$(basename "$dir")
    ./tools/optimize-images.sh "$project" "$dir"
done
```

### 7. Use Git Branches for Big Projects

```bash
git checkout -b project/roof-rack
# Work on project
git commit -m "Work in progress"
# When done:
git checkout main
git merge project/roof-rack
```

### 8. Create Image Galleries

Use multiple images side by side:
```markdown
<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">

![Before](/assets/images/projects/lift/before.jpg)
![After](/assets/images/projects/lift/after.jpg)

</div>
```

### 9. Add Comparison Sliders

(Future enhancement - not implemented yet)

### 10. Cross-Reference Projects

Link related builds:
```markdown
This build pairs well with my [Lift Kit Installation](/projects/lift-kit-installation).
```

---

## 📚 Resources

**Learn Markdown:**
- https://www.markdownguide.org/
- https://commonmark.org/help/

**Image Tools:**
- ImageMagick: https://imagemagick.org/
- https://tinypng.com/ (online optimization)
- https://squoosh.app/ (online compression)

**Editors:**
- VS Code: https://code.visualstudio.com/
- MacDown: https://macdown.uranusjr.com/
- Typora: https://typora.io/

---

## 🎓 Learning Path

**Week 1: Get Comfortable**
1. Create first project using interactive tool
2. Add 3-5 images
3. Preview locally
4. Publish

**Week 2: Improve Quality**
1. Better photo composition
2. More detailed descriptions
3. Add pro tips sections
4. Embed YouTube video

**Week 3: Streamline Process**
1. Build your own template
2. Create shortcuts/aliases
3. Batch process images
4. Faster turnaround

**Week 4: Advanced**
1. Custom formatting
2. Image galleries
3. Comparison tables
4. Cross-references

---

## 💡 Your Turn!

Try it now:

```bash
./tools/create-project-interactive.sh
```

Create your first project in < 10 minutes!
