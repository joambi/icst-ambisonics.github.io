# ICST Residency Page Templates

This folder contains templates for creating new residency pages on ambisonics.ch.

---

## Files

| File | Use for |
|------|---------|
| `TEMPLATE_Residency_Artist.md` | Individual artist page (English) |
| `TEMPLATE_Residency_Artist.de.md` | Individual artist page (German) |
| `TEMPLATE_Residency_Year_Overview.md` | Yearly overview page (e.g. "2027 ICST Artist in Studio-Residency") |

---

## How to create a new artist page

### Step 1 – Create the folder

In `content/Residenzen/`, create a new folder named after the artist:

```
content/Residenzen/Firstname Lastname/
```

### Step 2 – Copy the template

Copy `TEMPLATE_Residency_Artist.md` into the new folder and rename it `index.md`.
For the German version, copy `TEMPLATE_Residency_Artist.de.md` → `index.de.md`.

### Step 3 – Add images

Place all image files directly in the artist's folder.
Recommended naming:

| Filename | Purpose |
|----------|---------|
| `portrait.jpg` | Main portrait photo (used at the top) |
| `studio-01.jpg` | Studio impression 1 |
| `studio-02.jpg` | Studio impression 2 |

### Step 4 – Fill in the content

Replace all `[PLACEHOLDER]` values in the frontmatter and text.
Remove any sections that don't apply (e.g. no audio works yet → delete that table).

### Step 5 – Add to the yearly overview

Open the corresponding year's overview page (e.g. `content/Residenzen/ICST Studio Residences 2027/index.md`) and add a short entry for the artist using the pattern in `TEMPLATE_Residency_Year_Overview.md`.

---

## Checklist before publishing

- [ ] `title:` set to artist's full name
- [ ] `date:` set to residency start date
- [ ] Portrait image present and referenced correctly
- [ ] Bio text complete (2–4 sentences)
- [ ] Project description complete
- [ ] Audio works or outcomes added (if available)
- [ ] Entry added to the yearly overview page
- [ ] German version (`index.de.md`) also updated

---

## Best practice: what makes a good residency page?

Look at **Nandele Maguni** (`content/Residenzen/nandele_maguni/index.md`) as a reference.
It has:
- A clear project description
- Studio photos
- Direct links to finished audio works (Stereo, Binaural, B-Format)
- A personal artistic statement

Look at **Ana Gonzalez Gamboa** for an example with a rich project concept description.

---

*Maintained by Johannes Schütt · ICST / ZHdK*
