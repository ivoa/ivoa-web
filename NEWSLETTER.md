
# How to create a newsletter?

## Using a template

A newsletter is a content with a fairly similar structure from one newsletter to
another. In order to help creation of such content, it is possible to use a kind
of template (Hugo calls this an
[Archetype](https://gohugo.io/content-management/archetypes/)).
One exists for newsletters (and can be modified when desired ; see next main
section ["How to edit the template?"](#how-to-create-a-newsletter)).

To create a newsletter:

1. (Optional) Ensure Hugo is locally installed (`make install`).

2. Run the following command, where `XXX` is the number of the newsletter to
   create (e.g. `026`):

   ```bash
   ./hugo-bin/hugo new content newsletter/XXX.md
   ```

3. Edit the file `content/newsletter/XXX.md`. There are content placeholders all
   over this file ; search for all occurences of `TBD` and you will find them.
   Just replace them by the content you would like to have.

## Manual method

1. Create a file called `XXX.md` (where `XXX` is the number of the newsletter to
create ; e.g. `026`) in the directory `content/newsletter/`.

2. Starts with a header such as the following:

   ```md
   ---
   title: "IVOA Newsletter - November 2024"
   date: 2024-11-01T10:58:36+02:00
   tags:
   - news
   highlights:
   - ...
   ---
   ```

3. Then, just write the content of the newsletter. You can get inspired by the
   previous newsletters available in the directory `content/newsletter/`.

# How to edit the template?

## The archetype itself

The structure and content of the newsletters have already evolved few times in
the past. Such change is still possible in the future of the newsletters. When
it does, one has just to update the archetype itself:
[archetypes/newsletter.md](archetypes/newsletter.md)

## The layout

As special content, newsletters have a dedicated layout (called _template_ in
the Hugo documentation), or in other words, how the resulting HTML page is
rendered. If one wants to change this layout, there are two files to look at:

- **[layouts/newsletter/list.html](layouts/newsletter/list.html):** layout for
  the newsletters index page (aka <https://ivoa.net/newsletter/>).

- **[layouts/newsletter/single.html](layouts/newsletter/single.html):** layout
  for a single newsletter.

Layouts are written in HTML with some dynamic parts written with the Go
language.

To get more information about Hugo layouts, take a look at the
[corresponding Hugo documentation](https://gohugo.io/templates/introduction/).
You can also look at the other layouts of this project in
[layouts/_default/](layouts/_default/) as working examples.

This layout relies on CSS styles available in
[static/css/ivoa.css](static/css/ivoa.css) ; search for the styles with the
class `.newsletter`.

## Social links

Social links are inserted in the latest newsletters. This is done by adding the
following macro or snippet (called _shortcode_ by Hugo) in the desired
newsletter files:

{{< highlight md >}}
{{</* newsletter-social-links */>}}
{{< /highlight >}}

As the layout and the archetype, this may also be updated if necessary. One can
find the corresponding snippet in the file
[layouts/shortcodes/newsletter-social-links.html](layouts/shortcodes/newsletter-social-links.html).
As for layouts, this is a HTML snippet with dynamic parts written in Go.

To get more information about Hugo shortcodes, take a look at the
[corresponding Hugo documentation](https://gohugo.io/templates/shortcode/).
You can also look at the other shortcodes available in this project in
[layouts/shortcodes/](layouts/shortcodes/) as working examples.

This shortcode relies on CSS styles available in
[static/css/ivoa.css](static/css/ivoa.css) ; search for the section named
`SOCIAL LINKS`. Related images can be found in [static/images/](static/images/).