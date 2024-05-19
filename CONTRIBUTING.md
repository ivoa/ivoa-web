# Contributing

The new version of the IVOA website is being developed with [Hugo](https://gohugo.io/), a popular open-source tool for generating static websites. Instead of creating and modifying the site content directly in HTML, contributors will write [markdown](https://www.markdownguide.org/tools/hugo/) which is then converted to HTML. Since the site is now managed in Github using source control, development will follow a typical Git workflow, which will be covered in detail.

# Developing with Git and Github

## Installing Git

If you do not have it already, then you will need to [install git](https://github.com/git-guides/install-git) in order to work on the website locally.

## Checking Out the Repository

Now you can checkout the site's repository:

```
git clone https://github.com/ivoa/ivoa-web.git
```

You will now be able to make local changes to the content of the site, as well as build it.

## Making a Github Issue

All planned changes to the site beyond trivial ones, such as fixing spelling mistakes, should have their own dedicated issue in the [Github issue tracker](https://github.com/ivoa/ivoa-web/issues). An issue page provides an area for discussion, as well as a way to coordinate updates from multiple users in an organized fashion. Having an issue for your work also makes it easier to see if others are doing  something similar or even duplicating your work.

Here is the complete process for creating an issue:

- Go to the [ivoa-web issues page](https://github.com/ivoa/ivoa-web/issues) and click on "New Issue."
- Under "Add a title," write a brief phrase describing what you plan to do in the present tense, for example, "Add a page describing what the IVOA does." (You do not need to include punctuation in the title itself.)
- Add a description with additional details about what you plan to do under "Add a description," if you feel that it would be helpful.
- Finally, click on "Submit new issue."

You will now be redirected to the new page that was created for your issue. Take note of the number by the title (starts with "#"), as this will be used in creating the Git branch corresponding to the issue.

## Creating a Branch

You will need to create a branch which will contain the updates to the site.

If you are working from an existing copy of the repository rather than checking it out fresh, always update the `main` branch before creating your issue branch, like this:

```
git checkout main && git pull
```

Assuming your issue number was "1234", which is just an example number, the branch can be created as follows:

```
cd ivoa-web
git checkout -b iss1234
```

The above naming pattern which includes the issue number is preferred, as it clearly connects your branch to its corresponding issue in the Github tracker for reference.

You may additionally include some brief text in the branch name to describe what you plan on doing, such as `iss1234-add-a-page-about-the-ivoa`. The most important part is starting the branch name with `iss` followed by the number of the issue in the tracker.

# Working with Hugo

## Installing Hugo

Hugo is required for building the site locally in order to preview your changes. You may follow the [installation instructions](https://gohugo.io/installation/) for your platform.

A quick procedure to download Hugo on Linux from the [release page](https://github.com/gohugoio/hugo/releases) is:

```
wget https://github.com/gohugoio/hugo/releases/download/v0.126.1/hugo_0.126.1_Linux-64bit.tar.gz
tar -zxvf hugo_0.126.1_Linux-64bit.tar.gz
```

You should put the `hugo` file in a location that is on your system path, for example `/usr/local/bin` on Linux.

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

Now, you will be able to see the local preview of the site at this address in your browser:

[http://localhost:1313/](http://localhost:1313/)

You can view the changes continuously, as the `--watch` flag should make sure Hugo automatically reloads the site if you change something and then rebuild.

## Adding Webpages

The ["What is the VO?" page](content/pages/about/what_is_vo.md) provides a simple example of how to write a markdown file.

Most pages that you would add or change will go under [content/pages](https://github.com/ivoa/ivoa-web/tree/main/content/pages) in the repository.

A typical page will have a header follower by the content, as in:

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

The `date` is provided here for example purposes. Usually, you can leave it out and the dates from your Git commits will be used automatically.

When a page is added, typically ported from an existing static HTML page, it would usually be added to the [site index](https://github.com/ivoa/ivoa-web/blob/main/content/_index.html).

For example, here is the link in the index to the "What is the VO" webpage.

```
<li>
    <a href="{{<ref "pages/about/what_is_vo">}}">What is the VO?</a>
</li>
```

You do not need to include the `.md` file extension to reference a markdown file (`what_is_vo.md` is the file that is being referenced here).

# Adding Local Changes to the Site

## Committing and Pushing

After you have updated your local repository with changes, you will need to follow this standard set of steps to push them to the Github repository.

- Use `git add` to stage the changes locally
- Commit the changes with a message, e.g., `git commit -m "Added about the IVOA page"`
- Push your branch with a command such as `git push --set-upstream origin iss1234`

You should be able to push subsequently using only the command `git push`.

## Making a Pull Request

Once you are happy with the changes and have pushed all of them to the remote branch, you can open a pull request (PR) to ask for them to be merged into the main copy of the site.

Here is the process for doing this:

- From [this page](https://github.com/ivoa/ivoa-web/pulls) click on "New pull request."
- Select your branch from the list.
- In the next page, confirm that the changes you see look correct and up-to-date, and add descriptive text if you feel it is necessary.

Then click "Create pull request."

## Branch Versions of the Site

On the PR, a Github action will build a version of the website including your changes and then deploy it to a special URL so that your version of the site can be previewed and won't conflict with other development versions.

Under the "Checks" tab, there will be a workflow called "Deploy a branch version of the website." If this action completes successfully, you should then be able to view a full version of the site with your changes.

Assuming the issue branch was called `iss10`, then the development version would be accessible at:

[https://webtest.ivoa.info/v/iss10/](https://webtest.ivoa.info/v/iss10/)

Additionally, a list of all the development versions can be seen at:

[https://webtest.ivoa.info/v](https://webtest.ivoa.info/v)

For now, development versions of the website are not deleted but may be in the future.

## PR Approval and Merging

A reviewer will be assigned to your PR and will either approve it or request changes. Once the reviewer is satisfied and the PR is approved, your changes can be merged by clicking on the green "Merge" button. Typically, a reviewer will not merge the PR themselves, as you might want to make a few small changes after the approval.

## IVOA Test Website

The main URL of the test website is:

[https://webtest.ivoa.info/](https://webtest.ivoa.info/)

Once your PR has been merged, the changes you have made will be deployed there automatically.

# Getting Help

To get help about issues related to development of the IVOA website, please [open a ticket](https://github.com/ivoa/ivoa-web/issues/new) and add the "question" label. To do this, select the gear symbol next to "Labels" and click on "question." The developers of the site will attempt to answer your question on the issue page in a timely manner.
