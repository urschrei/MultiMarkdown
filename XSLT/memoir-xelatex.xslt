<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-Memoir converter by Fletcher Penney
	specifically designed for use with MultiMarkdown created XHTML

	Uses the LaTeX memoir class for output
	
	Modified for use with XeLaTeX (suggested by Talazem Al-Azem)
	
	MultiMarkdown Version 2.0.b6
	
	Alterations by Stephan Hügel (hugels@tcd.ie)
-->

<!-- 
# Copyright (C) 2005-2008  Fletcher T. Penney <fletcher@fletcherpenney.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	version="1.0">

	<xsl:import href="memoir.xslt"/>
	
	<xsl:output method='text' encoding='utf-8'/>

	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:head"/>
		<xsl:apply-templates select="html:html/html:body"/>
		<xsl:call-template name="latex-footer"/>
	</xsl:template>

	<xsl:template name="latex-header">
		<xsl:text>\usepackage{polyglossia} % XeTeX replacement for Babel
\setmainlanguage[variant=british]{english} % Polyglossia command

% Fonts
\usepackage{extfonts} % simple sty file which must be in your TeX path, define your fonts there

%\usepackage{fancyvrb}			% Allow \verbatim et al. in footnotes
\usepackage{graphicx}			% To include graphics in pdfs (jpg, gif, png)
\usepackage{booktabs}			% Better tables
\usepackage{tabulary}			% Support longer table cells
\usepackage[svgnames]{xcolor}	% Allow for color (annotations), see xcolor.pdf for details
\usepackage{ifthen}

% Recommended setting for Polyglossia
\usepackage[autostyle=true,english=british,autopunct=true,strict=true]{csquotes}

% Biblatex:
% ==============================================================================
% Pick one of the below to switch between MLA and Chicago styles

%\usepackage[style=mla,autocite=footnote,backref=true,backend=biber]{biblatex}

% == OR ==

% Change ‘notes’ to ‘authordate’ if you wish
\usepackage[notes,strict,autocite=footnote,backref=true,%
hyperref=true,autocite=footnote,backend=biber,bibencoding=UTF-8]%
{biblatex-chicago}

% ==============================================================================

% Support for hyperlinks, load after biblatex
\usepackage[pdfborder={0 0 0},%
colorlinks=true,linkcolor=MidnightBlue,citecolor=MidnightBlue,%
urlcolor=MidnightBlue]{hyperref}
% Set the PDF strings as Unicode
\hypersetup{unicode=true}

\def\myauthor{Author}			% In case these were not included in metadata
\def\mytitle{Title}
\def\mykeywords{}

%\def\mybibliostyle{plain}
\def\bibliocommand{}
%\VerbatimFootnotes
</xsl:text>
	</xsl:template>


</xsl:stylesheet>