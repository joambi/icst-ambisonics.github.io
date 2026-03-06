---
title: "Bloggen mit Hugo und GitHub Pages: Push unsere Hugo-Seite auf GitHub"
source: "https://carpentries-incubator.github.io/blogging-with-hugo-and-github-pages/03-push-to-github.html"
author:
published: 2026-03-03
created: 2026-03-03
description: "A Carpentries Lesson teaching foundational data and coding skills to researchers worldwide"
tags:
  - "clippings"
---
Blogging with Hugo and GitHub Pages

## Pushen Sie unsere Hugo-Seite auf GitHub

Zuletzt aktualisiert am 2025-01-30 | [Diese Seite bearbeiten](https://github.com/carpentries-incubator/blogging-with-hugo-and-github-pages/edit/main/episodes/03-push-to-github.md)

## Übersicht

### Fragen

- Wie speichern und verfolgen wir unsere lokalen Änderungen in `git`?
- Wie senden wir unsere Änderungen an unser GitHub-Repository?
- Wie öffnen und führen wir eine Pull Request zusammen?

### Ziele

- Schieben Sie die Hugo-Website auf GitHub und verwenden Sie eine Pull-Anforderung, um sie zu bringen die `main` Zweig

In dieser Episode werden wir die Änderungen, die wir in unserem Lokal vorgenommen haben, vorantreiben Repository zurück zum Remote-Repository auf GitHub.

Weitere Informationen zu den in dieser Episode verwendeten Workflows finden Sie [unter Versionssteuerung mit Git](https://swcarpentry.github.io/git-novice/) Software Carpentry Lektion.

1. Zuerst müssen wir es sagen `git` um alle zu verfolgen, die Veränderungen, die wir geschaffen haben. Wir tun dies, indem wir sie **hinzufügen** Gits Aufmarschgebiet.

### BASH

```bash
git add .
```

Wie wir vorher gesehen haben, hier die `.`bedeutet „bitte hinzufügen Alles an diesem aktuellen Standort.“

Wenn du jetzt rennst `git status` Sie sollten eine ähnliche sehen Ausgabe wie unten.

### BASH

```bash
git status
```

### AUSGANG

```
On branch setup-hugo
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    new file:   .gitmodules
    new file:   archetypes/default.md
    new file:   config.toml
    new file:   themes/anatole
```

1. Um git zu sagen, dass er einen Schnappschuss (oder "Commit") des aktuellen Zustands von unsere Dateien, wir verwenden die `git commit` Kommando, vorbei an der `-m` Flag, um eine Nachricht darüber zu hinterlassen, was wir haben geändert.

### BASH

```bash
git commit -m "Initial setup of blog site"
```

Die Ausgabe sollte ähnlich wie unten aussehen.

### AUSGANG

```
[setup-hugo 62d794e] Initial setup of blog site
 4 files changed, 19 insertions(+)
 create mode 100644 .gitmodules
 create mode 100644 archetypes/default.md
 create mode 100644 config.toml
 create mode 160000 themes/anatole
```

Jetzt, wenn wir rennen `git status` Wieder sollten wir sehen, die Nachricht `nothing to commit, working tree clean`

1. Jetzt schieben wir diesen Commit von unserem lokalen Commit auf den GitHub Server, der die `git push` Befehl. Im folgenden Befehl, `origin` ist ein Hinweis auf das ursprüngliche Repo, auf dem wir eingerichtet haben GitHub und `setup-hugo` stellt eine Anweisung zum Erstellen dar eine neue Niederlassung auf dem von GitHub gehosteten Repo mit dem gleichen Namen wie unsere Lokal erstellter Zweig.

### BASH

```bash
git push origin setup-hugo
```

### AUSGANG

```
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote:
remote: Create a pull request for 'setup-hugo' on GitHub by visiting:
remote:      https://github.com/HelmUpgradeBot/HelmUpgradeBot.github.io/pull/new/setup-hugo
remote:
To https://github.com/HelmUpgradeBot/HelmUpgradeBot.github.io.git
* [new branch]      setup-hugo -> setup-hugo
```

1. Wenn wir zurück auf GitHub zu unserer Repo-Seite gehen, sollten wir jetzt eine Banner informiert uns, dass eine Niederlassung aktualisiert wurde und uns mit eine Option zu „Vergleichen & Pull Request“. Klick auf das Große, Grün Knopf!
![GitHub repo page with a banner and "Compare & pull request" button](https://carpentries-incubator.github.io/blogging-with-hugo-and-github-pages/fig/repo_with_pr_banner.png)

GitHub repo page with a banner and “Compare & pull request” button

You will be redirected to GitHub’s interface for opening a Pull Request (PR). Give your PR an informative title and a descriptive summary in the relevant boxes, then click “Create pull request”.

If we had any tests for our website, this is where they’d run before we merged the PR. However, we’ll set up our tests next, so go ahead and click “Merge pull request”, followed by “Confirm merge”.

If you head back over to the repo’s landing page, you’ll see our changes have now been added to the `main` branch - but that doesn’t mean our blog is live and deployed yet!

![The GitHub repo's `main` branch with the hugo files now added to it](https://carpentries-incubator.github.io/blogging-with-hugo-and-github-pages/fig/updated_repo.png)

The GitHub repo’s main branch with the hugo files now added to it

First, let’s update our local copy of the repo and then we can add a GitHub Action workflow to automatically deploy our website for us.

In your terminal, run the following `git checkout` and `git pull` commands.

### BASH

```bash
git checkout main
```

### OUTPUT

```
warning: unable to rmdir 'themes/anatole': Directory not empty
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
```

Note that, this time, we did not use the `-b` flag in the `git checkout` command because we are **switching to a branch that already exists**, not creating a new one.

### BASH

```bash
git pull
```

### OUTPUT

```
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (1/1), 636 bytes | 636.00 KiB/s, done.
From https://github.com/HelmUpgradeBot/HelmUpgradeBot.github.io
   594286e..cd19a8f  main       -> origin/main
Updating 594286e..cd19a8f
Fast-forward
 .gitmodules           | 3 +++
 archetypes/default.md | 6 ++++++
 config.toml           | 3 +++
 themes/anatole        | 1 +
 4 files changed, 13 insertions(+)
 create mode 100644 .gitmodules
 create mode 100644 archetypes/default.md
 create mode 100644 config.toml
 create mode 160000 themes/anatole
```

Key Points

- Local changes are saved and tracked using the `git add` and `git commit` commands
- The remote repository on GitHub is synced with a local repository using `git push`. The reverse sync is achieved with `git pull`.
- A Pull Request can be opened and merged in the GitHub browser interface