## NAME ##

MultiMarkdown

## SYNOPSIS ##
    
`MultiMarkdown.pl [ --html4tags ] [ --version ] [ -shortversion ] [*file* ... ]`  


## DESCRIPTION ##


This is a fork of the MultiMarkdown package, designed to provide compatibility
with the biblatex bibliography engine, the biber biblatex backend, and various
biblatex-compatible citation styles, in particular, The
Chicago Manual of Style “notes + bibliography” and MLA specifications.
It is intended exclusively for use with XeTeX (though it could easily be adapted).  
Its main purpose is to facilitate the production of high-quality PDF output in concert with the powerful citation and bibliography tools
offered by biblatex, using either TextMate or Scrivener (though any text editor will work).  
Some other (mostly technical) differences:  

* use of the new polyglossia multilingual typesetting package, which is a replacement for babel, designed for XeLaTeX
* tweaks to the article class (the title page and abstract are now on a single separate page)
* fonts are set via an external file (extfonts.sty, place it in your LaTeX path). This is intended for convenience, as you no longer have to specify fonts in the XSLT file(s). Please be aware that only fonts installed on your own system will work. 
	* the `otfinfo --family /path/to/font/fontname.extension` command, and the ‘Font Book’ application (on OS X) are extremely useful in this regard.
* 	In addition, the example external font file enables support for the experimental xetex-microtype package, which provides
	microtypographic features for selected fonts (in this case, Garamond Premier Pro). The included mt-GaramondPremrPro.cfg file
	should be placed in the same directory as the xetex-microtype package. See below for a link to the package. Please note that it will only work with Texlive 2010 (or rather: the XeTeX version supplied with it). If you're using Texlive 2009, it'll automatically be disabled, but you may want to comment it out anyway.
* use of British English language and paper options. Switching to US English is trivial, however.
	
The following TeX packages/addons, as well as their dependencies
are required in order for the bibliography features to function:
	
* biblatex (included in Texlive 2009)
* biber
* the biblatex Chicago “notes + bibliography” style files
* polyglossia (included in Texlive 2009)
* csquotes (included in Texlive, but obtaining the current version is recommended)
* optional: The biblatex MLA 0.9 style (currently in beta)
	
	
For more information about biblatex see:  
<http://www.ctan.org/tex-archive/help/Catalogue/entries/biblatex.html>  
	
For more information about biber see:  
<http://biblatex-biber.sourceforge.net/>  

For more information about polyglossia see:  
<http://www.tex.ac.uk/ctan/macros/xetex/latex/polyglossia/>	  

For more information about csquotes see:  
<http://www.ctan.org/tex-archive/macros/latex/contrib/csquotes/>  

For more information about the Chicago “notes” + bibliography" style see:  
<http://www.ctan.org/tex-archive/help/Catalogue/entries/biblatex-chicago-notes-df.html>  

For more information about the MLA style see:  
<http://www.ctan.org/tex-archive/help/Catalogue/entries/biblatex-mla.html>  

The current version of the MLA style (as of the 6th of July 2010) will **not** work with the latest biblatex package. If you wish to use it,
you'll have to obtain it yourself. I suggest <http://groups.google.com/group/comp.text.tex/> as a first stop.

For more information about xetex-microtype see:  
<http://www.mail-archive.com/xetex@tug.org/msg00631.html>  
<http://xetex.tk/mediawiki/index.php/Microtype_package_(preliminary_version)>  

Please also note that this configuration will **not** currently work with latexmk.pl (as of v4.15c), as it does not yet support biber.

**This is very much a work in progress, and may well break at any time – use at your own risk**  
  
---

	
MultiMarkdown is an extended version of Markdown. See the website for more information.  

<http://fletcherpenney.net/multimarkdown/>  

Markdown is a text-to-HTML filter; it translates an easy-to-read / easy-to-write structured text format into HTML. Markdown's text format is most similar to that of plain text email, and supports features such as headers, emphasis, code blocks, blockquotes, and links.  

Markdown's syntax is designed not as a generic markup language, but
specifically to serve as a front-end to (X)HTML. You can use span-level HTML tags anywhere in a Markdown document, and you can use block level HTML tags (like `<div>` and `<table>` as well).  

For more information about Markdown's syntax, see:  
<http://daringfireball.net/projects/markdown/>  

## OPTIONS ##

Use `"--"` to end switch parsing. For example, to open a file named "-z",  
use:  
`Markdown.pl -- -z`

`--html4tags`  
Use HTML 4 style for empty element tags, e.g.: `<br>`  

instead of Markdown's default XHTML style tags, e.g.: `<br />`  

`-v, --version`  
Display Markdown's version number and copyright information.

`-s, --shortversion`  
Display the short-form version number.  

## BUGS ##

To file bug reports or feature requests (other than topics listed in the Caveats section above) please send email to:  

support@daringfireball.net (for Markdown issues)  

owner@fletcherpenney.net (for MultiMarkdown issues)  

Please include with your report:  

1. the example input 
2. the output you expected 
3. the output (Multi)Markdown actually produced. 

## AUTHOR ##

John Gruber <http://daringfireball.net/>  

PHP port and other contributions by Michel Fortin <http://michelf.com/>  

MultiMarkdown changes by Fletcher Penney <http://fletcherpenney.net/>

## COPYRIGHT AND LICENSE ##

Original Markdown Code Copyright (c) 2003-2007 John Gruber (<http://daringfireball.net/>) All rights reserved.  

MultiMarkdown changes Copyright (c) 2005-2009 Fletcher T. Penney (<http://fletcherpenney.net/>) All rights reserved.  

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:  

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name "Markdown" nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

This software is provided by the copyright holders and contributors "as
is" and any express or implied warranties, including, but not limited
to, the implied warranties of merchantability and fitness for a
particular purpose are disclaimed. In no event shall the copyright owner
or contributors be liable for any direct, indirect, incidental, special,
exemplary, or consequential damages (including, but not limited to,
procurement of substitute goods or services; loss of use, data, or
profits; or business interruption) however caused and on any theory of
liability, whether in contract, strict liability, or tort (including
negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.

