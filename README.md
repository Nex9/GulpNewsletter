GulpNewsletter
==============

*Super simple responsive email template.*

This is a workflow I've been using for a while to create e-mail templates. With [gulp](http://gulpjs.com/), I build the template just as if it was a "normal" website, and then I let Gulp handle the "inlineing" of the CSS.

### How to use

After you have [installed node and gulp](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md). Just run

	$ npm install

and then

	$ gulp watch

In the `src` directory, edit the index.html and/or the main.less-file and you will get two versions in the `compiled` directory. One (index-external.html) with the compiled LESS/CSS file (for use with for example [CampaignMonitor](https://www.campaignmonitor.com/), which handles linked css-files automatically) and one version with inlined CSS. 

You can put images and other assets pretty much wherever you want, just use relative paths. I find it convenient to put them in the `compiled` directory. You could of course have them in the `src` directory, and just let gulp copy them over.

### About the template

The template that comes along in the `src` directory is more or less ready to be used, it is tested (with litmus) in most clients. There are some minor issues in Outlook 2007 and Mac Sparrow. Will be fixed sooner or later.

### More

You can read more about this gulpfile and template at this blog post (in swedish).