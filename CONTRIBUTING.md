# Contributing

The IVOA website is being developed with [Hugo](https://gohugo.io/), a popular open-source tool for generating static websites. Instead of creating and modifying the site content directly in HTML, contributors will write [markdown](https://www.markdownguide.org/tools/hugo/) for most content. Since the site is now managed in Github using source control, development will follow a typical Git workflow, which will be covered in detail.

# Development with Git and Github

You should [install git](https://github.com/git-guides/install-git) if it is not already present on your system.

An account on [Github](https://github.com) is required. Write access to
[ivoa/ivoa-web](https://github.com/ivoa/ivoa-web) is convenient for ongoing work;
one-time contributions are encouraged from **forks** (see [Getting Help](#getting-help)
if you need write access).

Before pushing your changes, you can preview locally. **Forks have full local
preview** via Docker (`make docker-preview`, `make docker-html`, optional
`./scripts/deploy-smoke.sh`). These previews do **not** require IVOA deploy
secrets. On a personal fork, a pull request (PR) still runs secret-free continuous
integration (CI): the **Build site** job (creating a downloadable **`site-public`**
artifact) and **Deploy smoke (mock SSH/rsync)** against a disposable mock
destination (to confirm rsync works). Forks do *not* get an automatic push of the
branch preview to `webtest.ivoa.info` — that path uses org-held secrets and is
same-repo / maintainer only (see [Branch Versions of the Site](#branch-versions-of-the-site)).

Pushing changes also requires working authentication, which is covered in the
[set up git](https://docs.github.com/en/get-started/getting-started-with-git/set-up-git)
documentation.

## Checkout the Repository

The site's repository may be checked out from Github as folows:

```
git clone https://github.com/ivoa/ivoa-web.git
```

You will now be able to make your intended changes locally and preview them.

## Local preview (Docker — recommended)

Before opening a PR, preview content **and** structural/layout changes with the
canonical Docker setup. This pins Node, Hugo extended, and Pagefind to the same
versions used in CI (`Makefile` / `Dockerfile`). You do **not** need Hugo or
Node installed on the host. Docker uses tools inside the image (`/usr/local/bin`)
and does **not** install into project-local `hugo-bin/` / `pagefind-bin/` (so a
later host-side `make preview` is not poisoned by container shims).

Requirements: [Docker](https://docs.docker.com/get-docker/) with Compose v2.

### How to verify before / after a PR

Copy-paste steps on a machine with Docker:

1. **Get the branch**
   ```
   git fetch origin
   git checkout <branch-name>
   git pull
   ```
   Example for this Docker work: `git checkout cursor/docker-parity-deploys-52dc && git pull`

2. **Live preview (layout + content)**
   ```
   docker compose down
   make docker-preview
   ```
   Equivalent: `docker compose up --build preview`.  
   Open [http://localhost:1313/](http://localhost:1313/) in a browser.  
   **Pass:** the IVOA home page loads (title/nav visible); edit a markdown file under `content/` and see Hugo reload.  
   Stop with `Ctrl+C`. If the container was built from an older image, recreate with `docker compose up --build --force-recreate preview`.

3. **Production-style static build only** (writes `./public` on the host; no upload)
   ```
   make docker-html
   ls public/index.html
   ```
   **Pass:** command exits 0 and prints `docker-html OK: public/index.html present`; `public/index.html` exists on disk.

4. **Optional full mock deploy** (build if needed + rsync into local OpenSSH mock — not IVOA servers)
   ```
   ./scripts/deploy-smoke.sh
   ```
   **Pass:** ends with `deploy-smoke OK`. Uses only the test key under `deploy/mock-ssh/`.

5. **After you open / update the PR — check GitHub Actions**
   - Open the PR → **Checks** (or the green/yellow/red status near the PR title) → workflow **CI**.
   - Confirm these job names are green (available for same-repo and fork PRs; no org deploy secrets):
     - **Build site** — Hugo/Pagefind build
     - **Deploy smoke (mock SSH/rsync)** — rsync into the disposable mock only (especially if you changed deploy/Docker/CI files)
   - Download the build artifact:
     1. Open the **Build site** job (or the workflow run summary).
     2. In the right sidebar / bottom **Artifacts** section, download **`site-public`**.
     3. Unzip it: you should see **`index.html`** at the top level of the artifact (the contents of `public/`).
   - A live URL under `https://webtest.ivoa.info/v/<branch>/` is a **separate**,
     org-secret deploy for same-repo PRs — not required to review fork work.

### Alternative: host tools (`make preview`)

If you prefer not to use Docker, install Node.js 20+ and run:

```
make preview
```

That installs the pinned Hugo/Pagefind binaries into the repo and serves the
same local preview on port 1313.

### Deploy credentials

Contributors **never** need IVOA `webtest` / production deploy keys. Real-host
deploys run only from GitHub Actions with org-held secrets. Local and CI deploy
smoke tests use a disposable `deploy-mock` OpenSSH target and the test-only
keypair under `deploy/mock-ssh/` (see [#146](https://github.com/ivoa/ivoa-web/issues/146)).

## Making a Github Issue

All updates to the site beyond trivial ones, such as fixing spelling mistakes, should have their own dedicated issue in the [Github issue tracker](https://github.com/ivoa/ivoa-web/issues).

Here is the complete process for creating an issue:

- Go to the [ivoa-web issues page](https://github.com/ivoa/ivoa-web/issues) and click on "New Issue."
- Under "Add a title," write a brief phrase describing what you plan to do in the present tense, for example, "Add a page describing what the IVOA does." (You do not need to include punctuation in the title itself.)
- Add a description with additional details about what you plan to do under "Add a description," if you feel that it would be helpful.
- Optionally, assign an appropriate tag such as "enhancement."
- Finally, click on "Submit new issue."

You will now be redirected to the new issue page. The number of the issue by the title (starts with "#") will be used in creating the Git branch corresponding to the issue.

## Creating a Branch

You will need to create a branch which will contain the updates to the site.

If you are working from an existing copy of the repository rather than checking it out for the first time, always update the `main` branch before creating your issue branch, as follows:

```
git checkout main && git pull
```

Assuming your issue number was "1234", which is just an example, a branch can be created as follows from your local `ivoa-web` directory:

```
git checkout -b iss1234
```

The above naming pattern is preferred to clearly connect your branch to a corresponding issue in the Github tracker for future reference and documentation of what changes are being made and by whom.

You may optionally include some brief text in the branch name to describe your work, such as `iss1234-add-a-page-about-the-ivoa`. The most important part is starting the branch name with `iss` followed by the number of the issue in the tracker.

# Working with Hugo

## Installation

Hugo can be used to build the site locally and preview your changes. You may follow the [installation instructions](https://gohugo.io/installation/) for your platform.

You can test that the `hugo` command works by executing this command:

```
hugo --help
```

This will show a lot of usage information in the terminal.

## Building the Site

Once you have changed an existing page or added a new one, the entire site can be regenerated with this simple command:

```
hugo -D
```

The `-D` argument will make sure that links within the site use the local development URL.

In order to view the local version of the site, you can run the Hugo web server:

```
hugo server --watch --port 1313 -DEF --printI18nWarnings
```

Now, you will be able to see a local preview of the site at this address in your browser: [http://localhost:1313/](http://localhost:1313/)

## Adding Content to the Site

The ["What is the VO?" page](content/about/what_is_vo.md) provides a simple example of a markdown file. Most pages that you would likely add or change will similarily be located under [content](https://github.com/ivoa/ivoa-web/tree/main/content) in the repository.

A typical markdown file will include a header followed by the page content, as in:

```
---
title: "What is the VO?"
date: 2024-02-09T10:00:00+02:00
draft: false
tags:
- about
---

The goal of the Virtual Observatory (VO) is most easily described by analogy with the World Wide Web.

[rest of content]
```

The `date` is provided here for example purposes only. Usually, you can leave it out and the dates from your last Git commit to that file will be used automatically.

If not already present, a link should be added to the [site map](https://github.com/ivoa/ivoa-web/blob/main/layouts/partials/sitemap.html) pointing to the new page, or you may need to add one or more links to other parts of the site. Please consult with the site administrators if you have questions about where you might need to add or update links based on your changes.

# Pushing Changes to Github

## Committing and Pushing

After you have updated your local repository with changes, you will need to follow this standard set of steps to push them to the Github repository.

- Use `git add` to stage the changes locally
- When you type `git status`, the files which were added should show in green (You may want to double check that all the files you intended to add are listed there and that additional files were not included accidentally.)
- Commit the changes with a message, e.g., `git commit -m "Add about the IVOA page"` (You may want to review [How to write better commit messages](https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/) for some guidelines on this step.)
- Push your branch with a command such as `git push --set-upstream origin iss1234`

Once your local branch is associated with a remote branch on Github, you should subsequently be able to push using only the simple command `git push`.

## Making a Pull Request

Once you have pushed all your changes, you may then open a pull request (PR) which is a request to merge your updates into the main copy of the site.

Here is the process for doing this:

- From [this page](https://github.com/ivoa/ivoa-web/pulls), click on "New pull request."
- Select your branch from the list
- In the next page previewing your PR, confirm that the changes you see look correct
- Add descriptive text if you feel it is necessary

Now click "Create pull request."

It would also be helpful under "Development" on the righthand menu to select your branch from the list in order to connect it to the PR. (You can search for the issue by its issue number in the search box.)

### PR checklist

- [ ] Issue linked / branch named `issNNNN-…` (per this guide)
- [ ] Followed [How to verify before / after a PR](#how-to-verify-before--after-a-pr): `make docker-preview` → http://localhost:1313 looks right (works from a fork; no IVOA keys)
- [ ] Optional: `make docker-html` produced `public/index.html` (or `./scripts/deploy-smoke.sh` printed `deploy-smoke OK`)
- [ ] On the PR **Checks** tab, **Build site** is green; artifact **`site-public`** downloads and contains `index.html`
- [ ] If you changed deploy/Docker/CI files: **Deploy smoke (mock SSH/rsync)** is also green
- [ ] No secrets or real deploy credentials requested or committed
- [ ] Not relying on a `webtest.ivoa.info` URL unless you have a same-repo PR that got the org-secret branch deploy

## Branch Versions of the Site

**Same-repo PRs** (branch on `ivoa/ivoa-web`) still get an automatic branch
deploy to the maintainer staging host via rsync and org-held secrets
(see [#146](https://github.com/ivoa/ivoa-web/issues/146)). That is a convenience
URL for reviewers — not the only way to preview.

**Fork PRs** typically skip that webtest upload (no org secrets in the fork
workflow context). Fork contributors still have:

- Local Docker preview / build (`make docker-preview`, `make docker-html`)
- Optional local mock deploy (`./scripts/deploy-smoke.sh`)
- CI **Build site** + downloadable **`site-public`** artifact
- CI **Deploy smoke (mock SSH/rsync)** (mock only; no IVOA keys)

Assuming the issue branch was called `iss10`, the action completed successfully,
and the PR is from the same repository (not a fork), the webtest URL would be:

[https://webtest.ivoa.info/v/iss10/](https://webtest.ivoa.info/v/iss10/)

Additionally, a list of all available development versions of the site can be viewed at:

[https://webtest.ivoa.info/v](https://webtest.ivoa.info/v)

For now, these development versions are not deleted automatically but may be in the future.

## PR Approval and Merging

A reviewer will be assigned by the administrators to look at your PR and approve it or request changes before approval. Once the PR has been approved, the branch can be merged by clicking on the green "Merge" button. Typically, a reviewer will not merge the PR themselves, as you might want to make minor changes after the approval, such as fixing spelling or grammar. (However, major changes should _not_ be made to a PR branch after it has been reviewed, as that might require a re-review.)

## IVOA Test Website

The main URL of the test website is:

[https://webtest.ivoa.info/](https://webtest.ivoa.info/)

Once your PR has been merged, the changes you have made will be deployed there automatically.

# Getting Help

The #ivoa-web channel on the [https://ivoa.slack.com](IVOA Slack) can be used to ask questions related to site development.

You may alternately [open a ticket in the issue tracker](https://github.com/ivoa/ivoa-web/issues/new) and add the "question" label. The developers of the site will attempt to answer your question on the issue page in a timely manner.
