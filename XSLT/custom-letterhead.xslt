<?xml version='1.0' encoding='utf-8'?>

<!-- Custom Letterhead by Fletcher Penney

	Demonstration of how to customize the default letterhead template
		in MultiMarkdown with default return address information, as
		well as a custom logotype.

	Uses the fletcherpenney.sty file available at:
		http://fletcherpenney.net/XSLT_Files

	To include a signature, add `Graphic Signature` to your metadata,
		and include a `signature.pdf` file in your LaTeX class files.

	Must be processed with XeLaTeX

	MultiMarkdown Version 2.0.b6

	$Id: custom-letterhead.xslt 525 2009-06-15 18:45:44Z fletcher $
-->

<!-- 
# Copyright (C) 2007-2009  Fletcher T. Penney <fletcher@fletcherpenney.net>
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

	<xsl:import href="letterhead.xslt"/>
	
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

	\usepackage{fancyvrb}			% Allow \verbatim et al. in footnotes
	\usepackage{graphicx}			% To include graphics in pdf's (jpg, gif, png, etc)
	\usepackage{booktabs}			% Better tables
	\usepackage{tabulary}			% Support longer table cells
	\usepackage[svgnames]{xcolor}	% Allow for color (annotations), see xcolor.pdf for details
	\usepackage{ifthen}

	% Recommended setting for Polyglossia
	\usepackage[autostyle=true,english=british,autopunct=true,strict=true]{csquotes}

	% Biblatex
	\usepackage[style=mla,autocite=footnote,backref=true,backend=biber]{biblatex}

	% Support for hyperlinks, load after biblatex
	\usepackage[pdfborder={0 0 0},colorlinks=true,linkcolor=MidnightBlue,citecolor=MidnightBlue,urlcolor=MidnightBlue]{hyperref}
	% Set the PDF strings as Unicode
	\hypersetup{unicode=true}

	\def\myauthor{Author}			% In case these were not included in metadata
	\def\mytitle{Title}
	\def\mykeywords{}

	\def\mybibliostyle{plain}
	\def\bibliocommand{}
	\VerbatimFootnotes
	</xsl:text>
		</xsl:template>

	<xsl:template name="return-address-defaults">
		<xsl:text>% Default info for return address
% These should include '\\' where appropriate for line endings

\def\defaultemail{\href{mailto:hugels@tcd.ie}{hugels@tcd.ie} \\}
\def\defaultposition{}
\def\defaultdepartment{}
\def\defaultaddress{103 Meadowvale \\ Clonkeen Road, Co. Dublin \\}
\def\defaultphone{Tel +353 86 829 4881 \\}
\def\defaultweb{}

% Define height for logo and return address
\def\logoheight{1.2in}

% Define the fl ligature for linux compatibility
\chardef\fl="FB02

% Define Logo or something for upper left corner
\def\coverlogo{
\font\logo="Didot:mapping=tex-text" at 24pt \logo
\href{mailto:hugels@tcd.ie}{\St ephan\color{accent}Hügel\color{black}}
}

% Use my stylesheet
\usepackage{fletcherpenney}

% Define signature
\ifx\signature\undefined
	\def\signature{~ \\ Sincerely,\\
	\ifx\graphicsignature\undefined
	
	\else
		\resizebox{2in}{!}{\includegraphics{signature}}\\
	\fi
\myauthor}
\else
\fi

</xsl:text>
	</xsl:template>


</xsl:stylesheet>
