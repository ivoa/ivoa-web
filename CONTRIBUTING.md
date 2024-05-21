# Contributing

The new version of the IVOA website is being developed with [Hugo](https://gohugo.io/), a popular open-source tool for generating static websites. Instead of creating and modifying the site content directly in HTML, contributors will write [markdown](https://www.markdownguide.org/tools/hugo/) for most content. Since the site is now managed in Github using source control, development will follow a typical Git workflow, which will be covered in detail.

# Development with Git and Github

You should [install git](https://github.com/git-guides/install-git) if it is not already present on your system.

An account on [Github](https://github.com) is required, along with write permissions on the [ivoa-web repository](https://github.com/ivoa/ivoa-web). Please refer to the [Getting Help](#getting-help) section for information on how to request write access to the repository.

## Checkout the Repository

The site's repository may be checked out from Github as folows:

```
git clone https://github.com/ivoa/ivoa-web.git
```

You will now be able to make your intended changes locally and preview them.

## Making a Github Issue

All updates to the site beyond trivial ones, such as fixing spelling mistakes, should have their own dedicated issue in the [Github issue tracker](https://github.com/ivoa/ivoa-web/issues).

Here is the complete process for creating an issue:

- Go to the [ivoa-web issues page](https://github.com/ivoa/ivoa-web/issues) and click on "New Issue."
- Under "Add a title," write a brief phrase describing what you plan to do in the present tense, for example, "Add a page describing what the IVOA does." (You do not need to include punctuation in the title itself.)
- Add a description with additional details about what you plan to do under "Add a description," if you feel that it would be helpful.
- Optionally, assign an appropriate tag
- Finally, click on "Submit new issue."

You will now be redirected to the new page that was created for your issue. Take note of the number by the title (starts with "#"), as this will be used in creating the Git branch corresponding to the issue.

## Creating a Branch

You will need to create a branch which will contain the updates to the site.

If you are working from an existing copy of the repository rather than checking it out for the first time, always update the `main` branch before creating your issue branch, like this:

```
git checkout main && git pull
```

Assuming your issue number was "1234", which is just an example, a branch can be created as follows:

```
cd ivoa-web
git checkout -b iss1234
```

The above naming pattern is preferred since it clearly connects your branch to its corresponding issue in the Github tracker for future reference.

You may additionally include some brief text in the branch name to describe what you plan on doing, such as `iss1234-add-a-page-about-the-ivoa`. The most important part is starting the branch name with `iss` followed by the number of the issue in the tracker.

# Working with Hugo

## Installation

Hugo is required for building the site locally in order to preview your changes. You may follow the [installation instructions](https://gohugo.io/installation/) for your platform.

You can test that the `hugo` command works by executing this command:

```
hugo --help
```

This will show a lot of usage information in the terminal.

## Building the Site

Once you have changed an existing page or added a new one, Hugo can regenerate the entire site with this simple command:

```
hugo
```

But this will generate links which will not work locally, as they will reference the URL of the actual site rather than your local copy.

So instead, we will deploy a development version of the site:

```
hugo -D
```

In order to view your changes, you can run the Hugo web server like this:

```
hugo server --watch --port 1313 -DEF --printI18nWarnings
```

Now, you will be able to see a local preview of the site at this address in your browser: [http://localhost:1313/](http://localhost:1313/)

## Adding Content to the Site

The ["What is the VO?" page](content/pages/about/what_is_vo.md) provides a simple example of a markdown file. Most pages that you would likely add or change will similarily be located under [content/pages](https://github.com/ivoa/ivoa-web/tree/main/content/pages) in the repository.

A typical markdown file will have a header followed by the page content, as in:

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

The `date` is provided here for example purposes only. Usually, you can leave it out and the dates from your Git commits will be used automatically.

When a page is added, it should usually be added to the [site index](https://github.com/ivoa/ivoa-web/blob/main/content/_index.html) in the appropriate place if this link is not already present.

For example, here is the link in the index to the "What is the VO" webpage.

```
<li>
    <a href="{{<ref "pages/about/what_is_vo">}}">What is the VO?</a>
</li>
```

You do not need to include the `.md` file extension to reference a markdown file when linking in this way (`what_is_vo.md` is the file that is being referenced here).

# Pushing Changes to Github

## Committing and Pushing

After you have updated your local repository with changes, you will need to follow this standard set of steps to push them to the Github repository.

- Use `git add` to stage the changes locally
- When you type `git status`, the files which were added should show in green (You may want to double check that all the files you intended to add are listed there and that additional files were not included accidentally.)
- Commit the changes with a message, e.g., `git commit -m "Added about the IVOA page"`
- Push your branch with a command such as `git push --set-upstream origin iss1234`

You should be able to push subsequently using only the command `git push`.

## Making a Pull Request

Once you have pushed all your changes, you may then open a pull request (PR) which is a request to merge your updates into the main copy of the site.

Here is the process for doing this:

- From [this page](https://github.com/ivoa/ivoa-web/pulls), click on "New pull request."
- Select your branch from the list
- In the next page previewing your PR, confirm that the changes you see look correct
- Add descriptive text if you feel it is necessary

Now click "Create pull request."

## Branch Versions of the Site

Your changes will be included in a new branch version of the website after you open a PR. The deployment of this site is triggered automatically in the PR checks.

Assuming the issue branch was called `iss10` and the action complete succesfully, the development version would be accessible at:

[https://webtest.ivoa.info/v/iss10/](https://webtest.ivoa.info/v/iss10/)

Additionally, a list of all available development versions of the site can be viewed at:

[https://webtest.ivoa.info/v](https://webtest.ivoa.info/v)

For now, these development versions are not deleted automatically but may be in the future.

## PR Approval and Merging

A reviewer will be assigned by the administrators and will either approve your PR or request changes. Once the PR is approved, the branch can be merged by clicking on the green "Merge" button. Typically, a reviewer will not merge the PR themselves, as you might want to make minor changes after the approval. (Making major changes to a branch after it has been approved is highly discouraged.)

## IVOA Test Website

The main URL of the test website is:

[https://webtest.ivoa.info/](https://webtest.ivoa.info/)

Once your PR has been merged, the changes you have made will be deployed there automatically.

# Getting Help

To get help about issues related to development of the IVOA website, please [open a ticket](https://github.com/ivoa/ivoa-web/issues/new) and add the "question" label. To do this, select the gear symbol next to "Labels" and click on "question." The developers of the site will attempt to answer your question on the issue page in a timely manner.
