# Quick Start: Adding Your First Project

## Method 1: Use the Script (Easiest)

```bash
# Make the script executable (first time only)
chmod +x add-project.sh

# Create a new project
./add-project.sh "my-first-project"

# This will create: src/content/projects/my-first-project.md
```

## Method 2: Manual

1. **Copy the template:**
   ```bash
   cp new-project-template.md src/content/projects/my-project.md
   ```

2. **Edit the file** - update the frontmatter (everything between `---`)

3. **Add images** to `public/assets/images/projects/`

4. **Preview:**
   ```bash
   npm run dev
   ```
   Open http://localhost:4321/projects

5. **Publish:**
   ```bash
   git add .
   git commit -m "Add new project"
   git push
   ```

## Your First Project

Let's add the lift kit project as an example:

### Step 1: The project file already exists!
`src/content/projects/lift-kit-installation.md`

### Step 2: Add placeholder images

For now, create placeholder images or use what you have:

```bash
# Create a placeholder (you'll replace these)
touch public/assets/images/projects/lift-kit-hero.jpg
touch public/assets/images/projects/lift-kit-planning.jpg
touch public/assets/images/projects/lift-kit-parts.jpg
touch public/assets/images/projects/lift-kit-install.jpg
touch public/assets/images/projects/lift-kit-results.jpg
```

Or copy real images:
```bash
cp /path/to/your/image.jpg public/assets/images/projects/lift-kit-hero.jpg
```

### Step 3: Preview

```bash
npm run dev
```

Visit:
- All projects: http://localhost:4321/projects
- Lift kit project: http://localhost:4321/projects/lift-kit-installation

### Step 4: Customize

Edit `src/content/projects/lift-kit-installation.md` with your actual content.

## File Structure

```
Your repository/
│
├── src/
│   ├── content/
│   │   ├── config.ts  (defines project schema)
│   │   └── projects/
│   │       ├── lift-kit-installation.md  (example)
│   │       └── your-project.md  (your new projects)
│   │
│   └── pages/
│       └── projects/
│           ├── index.astro  (lists all projects)
│           └── [slug].astro  (renders individual project)
│
├── public/
│   └── assets/
│       └── images/
│           └── projects/
│               └── your-images.jpg
│
├── new-project-template.md  (copy this for new projects)
├── add-project.sh  (helper script)
├── PROJECT-GUIDE.md  (detailed guide)
└── QUICK-START.md  (this file)
```

## Next Steps

1. **Restore navigation:** The "Builds" link should now be visible in the nav
2. **Add real images** for your projects
3. **Create more projects** using the template
4. **Customize** the example project with your actual content

## Tips

- **Slug = filename** - If your file is `rock-sliders.md`, the URL will be `/projects/rock-sliders`
- **Images are public** - Anything in `public/` is served directly
- **Markdown = content** - Write naturally, images embed with `![alt text](/path)`
- **YouTube = easy** - Just add the video ID to frontmatter

## Common Questions

**Q: How do I get my YouTube video ID?**
A: From `https://www.youtube.com/watch?v=dQw4w9WgXcQ`, copy `dQw4w9WgXcQ`

**Q: Where do featured projects show?**
A: Set `featured: true` in frontmatter (future homepage feature)

**Q: Can I use subfolders for images?**
A: Yes! `public/assets/images/projects/lift-kit/hero.jpg` works fine

**Q: How do I delete a project?**
A: Delete the markdown file from `src/content/projects/`

**Q: Do I need to restart the dev server?**
A: Usually no, but if you add/remove projects, restart helps

## Full Documentation

See [PROJECT-GUIDE.md](./PROJECT-GUIDE.md) for complete details.
