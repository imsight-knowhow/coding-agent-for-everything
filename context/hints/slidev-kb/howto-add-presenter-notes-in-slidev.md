# How to Add Presenter Notes in Slidev

Presenter notes (also called speaker notes) are hidden notes that appear only in Presenter Mode, not on the actual slides. They help you reference key points during presentations.

## Quick Reference

Use HTML comments at the **end of each slide** to add presenter notes:

```markdown
---
layout: cover
---

# My Slide Title

This content appears on the slide.

<!-- This is a presenter note - won't show on the slide -->
```

## Important Rules

1. **Position matters**: Notes must be at the end of the slide (after all visible content)
2. **Comment syntax**: Use HTML comment format `<!-- your note -->`
3. **Markdown support**: Basic Markdown and HTML work inside notes
4. **Multi-line support**: Multi-line comments work fine

## Examples

### Single-line Note

```markdown
---
# Introduction

Welcome to my presentation!

<!-- Remember to smile and make eye contact -->
```

### Multi-line Note with Markdown

```markdown
---
# Key Points

Here's what we'll cover today.

<!--
This is a **multi-line** note with formatting:
- Point 1: Introduction
- Point 2: Demo
- Point 3: Q&A

**Don't forget** to mention the special offer!
-->
```

### Note Position Matters

```markdown
---
# Slide 2

<!-- This is NOT a note - it's in the middle of the slide -->

The second page content

<!--
This IS a note - it's at the end of the slide
-->
```

## Viewing Presenter Notes

### Method 1: Navigation Bar Button
- Run your Slidev presentation: `npx slidev slides.md`
- Click the presenter button (👤) in the navigation bar at the bottom

### Method 2: Direct URL
- Visit `http://localhost:3030/presenter` (adjust port if different)
- Replace `3030` with your actual port number

### Presenter Mode Features
- Shows current slide and next slide
- Displays presenter notes for current slide
- Shows timer and slide progress
- Syncs automatically with audience view

## Tips

1. **Keep notes concise**: Focus on key talking points, not full scripts
2. **Use formatting**: Bold important points, use lists for clarity
3. **Sync multiple windows**: Open presenter mode on your screen, share play mode with audience
4. **Test beforehand**: Always check your notes in presenter mode before presenting

## Related Features

- **Click Markers**: Highlight notes sections and auto-scroll during animations
- **Recording**: Built-in recording feature works with presenter mode
- **Export**: Notes are included when exporting to PPTX format

## Source

- Official Documentation: https://sli.dev/guide/syntax#notes
- UI Guide: https://sli.dev/guide/ui#presenter-mode
