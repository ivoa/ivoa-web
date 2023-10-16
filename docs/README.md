# Website documentation

## Adding new content

This document describes methods of adding new content to the IVOA website.
Please checkout a new branch and perform your writing locally.
Then make a merge request, so the changes can be checked before they are published to the website

### Links on the homepage
Adjusting the links on the homepage is done by updating [_index.html](../content/_index.html) in the `content` directory.

### Posts

Content, such as news, upcoming meetings, but also highlights, can be added by creating a new Markdown file (`index.md`) in the _content/posts_ directory. For organisation purposes, follow the structure `<year>/<title>/index.md`.

The content of the file should follow the following structure:
```
---
title: "My new page"
date: 2023-07-04T10:58:36+02:00
draft: false
author: John Doe
featured_image: cool_image.png
tags:
- banner
- news
---

Start of the content on the new page
```
Images should be added in the same directory as the new `index.md` file.


#### News & Upcoming meetings

To make the page show up under the _news & upcoming meetings_ section, you must add the tag `news` in the tags section of the preamble.

#### Highlights in the carrousel

To make the page show up in the carrousel, you must add the tag `banner` in the tags section of the preamble and a `features_image`. Only the latest(bases on the date in the post) _X_ amount of posts will be shown on the homepage.
