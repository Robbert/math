# Math on the web

The plan is develop some XSLT stylesheets to transform MathML to HTML and CSS, so you can read articles using math expressions in all browsers.

## Getting started

[MathJax](http://www.mathjax.org/) is a mature project that already can render MathML as HTML and CSS. If you need something for your site that just works, check out MathJax.

## Hackers unite!

Personally I didn't felt comfortable using MathJax. I found its codebase incomprehensible, and performance was poor. When you need something that requires one or more of the following, please consider helping getting this project on its feet.

* Top-notch performance
* Very hackable codebase
* Server-side conversion
* Client-side conversion

These secondary goals would be cool as well:

* Support for e-readers like the Kindle
* Extended version with IE6 and IE7 support

I really don't want to sacrifice a clean and accessible codebase for legacy browser support, so we'll have to use modules and overrides for that.

## License: LGPL

We're using the same license as MathJax uses, so with enough help we can offer a drop-in replacement for MathJax in time.