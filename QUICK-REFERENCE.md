# Quick Reference Card

Copy this cheat sheet for fast project creation!

---

## 🚀 Create New Project (Easiest Way)

```bash
./tools/create-project-interactive.sh
```

**What it does:**
- Asks for project details (title, category, etc.)
- Extracts YouTube ID from URL
- Optimizes and copies images
- Creates formatted markdown file
- Opens in editor

**Time: ~2-5 minutes**

---

## 📸 Image Workflow

### Automatic (Recommended)

Interactive tool handles this. Just:
1. Dump photos in a folder (any names)
2. Point tool to folder when prompted
3. Done! Images optimized and copied

### Manual

```bash
# Optimize images from folder
./tools/optimize-images.sh project-slug ~/Photos/MyProject

# Or just copy (no optimization)
cp ~/Photos/MyProject/* public/assets/images/projects/my-project/
```

**Then rename descriptively:**
```bash
cd public/assets/images/projects/my-project
mv IMG_001.jpg hero.jpg
mv IMG_002.jpg parts.jpg
mv IMG_003.jpg install-1.jpg
mv IMG_004.jpg results.jpg
```

---

## ✏️ Edit Project

**Files are here:**
```
src/content/projects/project-slug.md
```

**Edit with:**
- VS Code (recommended - see below)
- Any text editor
- MacDown, Typora, or similar

**Preview changes:**
```bash
npm run dev
# Visit: http://localhost:4321/projects/project-slug
```

---

## 🎬 YouTube Integration

**In frontmatter:**
```yaml
youtubeId: "dQw4w9WgXcQ"
```

**Get ID from URL:**
```
https://www.youtube.com/watch?v=dQw4w9WgXcQ
                                ^^^^^^^^^^^
```

Interactive tool extracts this automatically!

---

## 📝 Project Frontmatter Template

```yaml
---
title: "Project Title"
description: "Short 1-2 sentence description"
date: "2024-03-15"  # YYYY-MM-DD
category: "Suspension"  # Suspension, Armor, Storage, Electrical, Recovery, Camping, Other
difficulty: "Intermediate"  # Beginner, Intermediate, Advanced
heroImage: "/assets/images/projects/slug/hero.jpg"
youtubeId: "VIDEO_ID"  # Optional
featured: false
tags: ["tag1", "tag2"]  # Optional
---
```

---

## 🖼️ Image Markdown

```markdown
![Description](/assets/images/projects/project-slug/image.jpg)
```

**Must start with `/`** - this is critical!

---

## 📁 File Structure

```
realsystem.github.io/
├── src/content/projects/
│   ├── lift-kit.md
│   └── your-project.md
├── public/assets/images/projects/
│   ├── lift-kit/
│   │   ├── hero.jpg
│   │   └── ...
│   └── your-project/
│       └── ...
└── tools/
    └── *.sh (helper scripts)
```

---

## 🛠️ Useful Commands

```bash
# List all projects
./tools/list-projects.sh

# Preview specific project
./tools/preview-project.sh project-slug

# Start dev server
npm run dev
# OR
./tools/watch-and-reload.sh

# Build for production
npm run build

# Publish
git add .
git commit -m "Add project: Project Name"
git push
```

---

## 🎨 VS Code Setup

**1. Open project in VS Code:**
```bash
code .
```

**2. Install recommended extensions** (prompted automatically)

**3. Edit markdown with split preview:**
- Open `.md` file
- Press `Cmd+K V` (Mac) or `Ctrl+K V` (Windows)
- Edit left, preview right

**4. Paste images directly:**
- Copy image (screenshot, photo)
- In markdown file: `Cmd+Alt+V`
- Auto-saves to correct folder
- Auto-inserts markdown

---

## 📋 Content Template Structure

```markdown
## Introduction
Why you did this, what it accomplishes

![Hero image](/path)

## Planning
Research, options, decisions

## Parts and Tools
**Tools:** list
**Parts:** list

![Parts](/path)

## Installation
Step-by-step process

### Step 1
Details...

![Install](/path)

## Results
Outcome, measurements

![Results](/path)

## Pro Tips
- Tip 1
- Tip 2

## Conclusion
Final thoughts

**Stats:**
- Time: X hours
- Difficulty: X/10
- Cost: $XXX
```

---

## 🐛 Common Issues

### Images not showing?
```markdown
✅ /assets/images/projects/slug/image.jpg
❌ assets/images/projects/slug/image.jpg (no leading /)
❌ /public/assets/... (don't include public)
```

### Build error?
Check frontmatter:
- All required fields present?
- Date format: `"YYYY-MM-DD"`
- Category matches allowed list?
- Difficulty matches allowed list?
- Quotes around string values?

### YouTube not embedding?
```yaml
✅ youtubeId: "dQw4w9WgXcQ"
❌ youtubeId: "https://..." (no full URL)
❌ youtubeID: ... (lowercase 'd')
```

---

## ⚡ Quick Tips

1. **Use the interactive tool** - it handles everything
2. **Take photos as you work** - easier than remembering later
3. **Preview before committing** - run `npm run dev`
4. **Rename images descriptively** - `hero.jpg`, `parts.jpg`, not `IMG_1234.jpg`
5. **Copy good projects** - reuse structure from past successes
6. **Don't overthink it** - publish and improve later

---

## 📚 Full Documentation

- **[QUICK-START.md](QUICK-START.md)** - Get started in 5 min
- **[PROJECT-GUIDE.md](PROJECT-GUIDE.md)** - Complete guide
- **[TOOLS-GUIDE.md](TOOLS-GUIDE.md)** - Tools & workflow
- **[tools/README.md](tools/README.md)** - Tool documentation
- **[new-project-template.md](new-project-template.md)** - Markdown template

---

## 🎯 Workflow Summary

```
1. Shoot photos during build
   ↓
2. ./tools/create-project-interactive.sh
   ↓
3. Fill in content (replace placeholders)
   ↓
4. npm run dev (preview)
   ↓
5. git add . && git commit && git push
   ↓
6. Done! Live in ~2 min
```

---

## 💾 Save This!

Print this page or bookmark it. Everything you need on one page.

**Most important command:**
```bash
./tools/create-project-interactive.sh
```

This is your starting point for every new project.

Happy building! 🚗🏔️
