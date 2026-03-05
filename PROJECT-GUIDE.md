# How to Add a New Project

This guide explains how to add new build projects to your website.

## Quick Method (Using Script)

1. **Run the script:**
   ```bash
   ./add-project.sh "your-project-slug"
   ```
   Example: `./add-project.sh "rock-sliders-install"`

2. **Edit the created file** at `src/content/projects/your-project-slug.md`

3. **Add your images** to `public/assets/images/projects/`

4. **Preview:** `npm run dev` and visit http://localhost:4321/projects

---

## Manual Method (Step-by-Step)

### Step 1: Create Project File

Create a new markdown file in `src/content/projects/` with a descriptive slug:

```
src/content/projects/rock-sliders-install.md
```

**File naming rules:**
- Use lowercase letters
- Separate words with hyphens (not spaces or underscores)
- Be descriptive: `lift-kit-installation` not `project1`

### Step 2: Add Frontmatter

Copy this template to the top of your file and fill it out:

```yaml
---
title: "Project Title Here"
description: "Short description (1-2 sentences max)"
date: "2024-03-15"  # Format: YYYY-MM-DD
category: "Suspension"  # Options: Suspension, Armor, Storage, Electrical, Recovery, Camping, Other
difficulty: "Intermediate"  # Options: Beginner, Intermediate, Advanced
heroImage: "/assets/images/projects/your-project-hero.jpg"
youtubeId: "dQw4w9WgXcQ"  # Optional: Just the video ID from youtube.com/watch?v=THIS_PART
featured: false  # Set to true to show on homepage
tags: ["tag1", "tag2"]  # Optional
---
```

**Important fields:**
- `heroImage`: Main image shown in listings and at top of article
- `youtubeId`: Get from YouTube URL - just the ID part, not full URL
- `category`: Must be one of the listed options
- `difficulty`: Helps users know skill level needed

### Step 3: Write Content

Use Markdown formatting for your content:

```markdown
## Introduction

Your opening paragraphs here.

![Image description](/assets/images/projects/project-name-1.jpg)

## Planning

What research did you do?

### Subsection

More details...

**Bold text** and *italic text*

- Bulleted list
- Another item

1. Numbered list
2. Another item
```

### Step 4: Add Images

1. **Prepare your images:**
   - Resize to reasonable web size (1920px wide max)
   - Use JPG for photos, PNG for screenshots
   - Name descriptively: `lift-kit-installation-parts.jpg`

2. **Place images in:**
   ```
   public/assets/images/projects/
   ```

3. **Reference in markdown:**
   ```markdown
   ![Image caption](/assets/images/projects/your-image.jpg)
   ```

**Image best practices:**
- Hero image should be landscape (16:9 or 3:2 ratio)
- At least 1280x720px for hero image
- Show clear, well-lit shots of the build process
- 5-10 images per project is ideal

### Step 5: Optional - Add YouTube Video

If you have a build video:

1. Get the video ID from YouTube URL:
   ```
   https://www.youtube.com/watch?v=dQw4w9WgXcQ
                                    ^^^^^^^^^^^
   ```

2. Add to frontmatter:
   ```yaml
   youtubeId: "dQw4w9WgXcQ"
   ```

The video will automatically embed at the top of your project page.

### Step 6: Preview

1. **Start dev server:**
   ```bash
   npm run dev
   ```

2. **View your project:**
   - All projects: http://localhost:4321/projects
   - Your project: http://localhost:4321/projects/your-slug

3. **Check for:**
   - Images loading correctly
   - Formatting looks good
   - Links work
   - Video embeds (if used)

### Step 7: Publish

1. **Build site:**
   ```bash
   npm run build
   ```

2. **Commit changes:**
   ```bash
   git add src/content/projects/your-project.md
   git add public/assets/images/projects/your-images.jpg
   git commit -m "Add new project: Project Name"
   git push
   ```

GitHub Actions will automatically build and deploy your site.

---

## Project Structure Reference

```
realsystem.github.io/
├── src/
│   └── content/
│       └── projects/
│           ├── lift-kit-installation.md
│           ├── roof-rack-build.md
│           └── your-new-project.md
├── public/
│   └── assets/
│       └── images/
│           └── projects/
│               ├── lift-kit-hero.jpg
│               ├── lift-kit-parts.jpg
│               └── your-project-images.jpg
├── new-project-template.md  (template to copy)
└── add-project.sh  (helper script)
```

---

## Content Writing Tips

### Good Project Titles
✅ "Tacoma 3-Inch Lift Kit Installation"
✅ "DIY Rock Sliders for 3rd Gen Tacoma"
✅ "Building a Custom Roof Rack"

❌ "My Project"
❌ "Suspension"
❌ "Project #3"

### Good Descriptions
✅ "Complete guide to installing a 3-inch lift kit with detailed photos and torque specs."
✅ "Built custom aluminum roof rack for $300 instead of buying a $1200 commercial option."

❌ "Lifted my truck"
❌ "This was a fun project"

### Content Structure
Use this flow for most projects:

1. **Introduction** - Why you did this, what problem it solves
2. **Planning/Research** - Options you considered
3. **Parts & Tools** - Specific items needed
4. **Installation/Build** - Step-by-step process
5. **Results** - How it turned out, performance
6. **Pro Tips** - Things you learned
7. **Conclusion** - Final thoughts, would you do it again

### Make it SEO-Friendly
- Use descriptive headings (## Installing the Springs)
- Include part numbers and brands
- Add measurements and specs
- Use natural language (how you'd search for it)

---

## Troubleshooting

### Images not showing?
- Check path starts with `/` → `/assets/images/...`
- Check file actually exists in `public/assets/images/projects/`
- Check file name matches exactly (case-sensitive)

### Build errors?
- Check frontmatter has all required fields
- Check date format is `YYYY-MM-DD`
- Check category is one of the allowed values
- Check YAML syntax (no tabs, proper quotes)

### Video not embedding?
- Use just the video ID, not full URL
- Remove `youtubeId` line if no video (don't leave it blank)

---

## Examples

See `src/content/projects/lift-kit-installation.md` for a complete example.

---

## Need Help?

- Template file: `new-project-template.md`
- Example project: `src/content/projects/lift-kit-installation.md`
- Check Astro docs: https://docs.astro.build/en/guides/content-collections/
