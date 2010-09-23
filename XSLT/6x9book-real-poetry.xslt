<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-Memoir converter by Fletcher Penney
	specifically designed for use with MultiMarkdown created XHTML

	Uses the LaTeX memoir class for output with the twoside option
	
	Format as 6.0 in x 9.0 in page size
	
	Code blocks display in poetry mode using `clean-text-poetry`
	
	MultiMarkdown Version 2.0.b6
	
	$Id: 6x9book-real-poetry.xslt 499 2008-03-23 13:03:19Z fletcher $
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

	<xsl:import href="6x9book.xslt"/>
	<xsl:import href="clean-text-poetry.xslt"/>
	
	<xsl:template name="latex-paper-size">
		<xsl:text>%% Widen indentions for poetry
\setlength{\vgap}{\vindent}

%%% need more space for ToC page numbers
\setpnumwidth{2.55em}
\setrmarg{3.55em}

%%% need more space for ToC section numbers
\cftsetindents{part}{0em}{3em}
\cftsetindents{chapter}{0em}{3em}
\cftsetindents{section}{3em}{3em}
\cftsetindents{subsection}{4.5em}{3.9em}
\cftsetindents{subsubsection}{8.4em}{4.8em}
\cftsetindents{paragraph}{10.7em}{5.7em}
\cftsetindents{subparagraph}{12.7em}{6.7em}

%%% need more space for LoF numbers
\cftsetindents{figure}{0em}{3.0em}

%%% and do the same for the LoT
\cftsetindents{table}{0em}{3.0em}

%%% set up the page layout
\setstocksize{9in}{6in}
\settrimmedsize{9in}{6in}{*}	% Use entire page
\settrims{0pt}{0pt}

\setlrmarginsandblock{1.2in}{0.8in}{*}
\setulmarginsandblock{1in}{1in}{*}

\setmarginnotes{0.1pt}{0.2in}{\onelineskip}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}

%% Fix for the companion style header issue
%% http://www.codecomments.com/message459639.html

\setlength{\headwidth}{\textwidth}
 \addtolength{\headwidth}{\marginparsep}

 \addtolength{\headwidth}{\marginparwidth}
 \makerunningwidth{companion}{\headwidth}
 \makeheadrule{companion}{\headwidth}{\normalrulethickness}
 \makeheadposition{companion}{flushright}{flushleft}{}{}

\checkandfixthelayout

</xsl:text>
	</xsl:template>

	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:head"/>
		<xsl:text>\newcommand{\attrib}[1]{% 
\nopagebreak{\raggedleft\footnotesize #1\par}}


</xsl:text>		
		<xsl:apply-templates select="html:html/html:body"/>
		<xsl:call-template name="latex-footer"/>
	</xsl:template>

	<xsl:template name="latex-footer">
		<xsl:text>%
% Back Matter
%

\backmatter
%\appendixpage

%	Bibliography
\bibliographystyle{\mybibliostyle}
\bibliocommand

%	Glossary
\printglossaries


%	Indexes
\def\indexname{Index of Titles}
\printindex

\def\indexname{Index of First Lines}
\printindex[firstlines]

\end{document}
</xsl:text>
	</xsl:template>

	<xsl:template name="latex-document-class">
		<xsl:text>\documentclass[10pt,twoside]{memoir}
\usepackage{layouts}[2001/04/29]
\usepackage{modified-bringhurst}   % Available from http://fletcherpenney.net/
\usepackage{glossaries}
\makeglossaries
\makeindex
\makeindex[firstlines]

\def\mychapterstyle{companion}
\def\mypagestyle{companion}
\def\revision{}

		</xsl:text>
	</xsl:template>

	<!-- code block => Now it's poetry -->
	<xsl:template match="html:pre[child::html:code]">
		<xsl:text>\settowidth{\versewidth}{</xsl:text>
		<xsl:call-template name="longest-line">
			<xsl:with-param name="source">
				<xsl:value-of select="."/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text>}
\begin{verse} %[\versewidth]
</xsl:text>
		<!-- Create an index of first lines -->
		<xsl:text>\index[firstlines]{</xsl:text>
		<xsl:value-of select="substring-before(., $newline)"/>
		<xsl:text>}
</xsl:text>
		<xsl:call-template name="poetry-text">
			<xsl:with-param name="source">
				<xsl:value-of select="."/>
			</xsl:with-param>
		</xsl:call-template>		
		<xsl:text>
\end{verse}
</xsl:text>
		<!-- Display attribution if present -->
		<xsl:text>\attrib{</xsl:text>
			<xsl:apply-templates select="preceding-sibling::*[1][local-name() = 'p']/html:em" mode="attrib"/>
		<xsl:text>}
\vspace*{\fill}


</xsl:text>
		<apply-templates select="preceding-sibling::*[1][local-name() = 'p']" mode="attrib"/>
	</xsl:template>

	<xsl:template match="html:h3">
		<xsl:if test="preceding-sibling::*[1][local-name() != 'h2']">
			<xsl:text>\pagebreak
</xsl:text>
	</xsl:if>
<xsl:text>\vspace*{\fill}
\poemtitle{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\index{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<!-- attrib (italics following verse) -->
	<!-- ignore it by itself -->
	<xsl:template match="html:p[following-sibling::*[1][local-name() = 'pre']]">
	</xsl:template>

	<xsl:template match="html:p" mode="attrib">
		<xsl:text>\attrib{</xsl:text>
			<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
	</xsl:template>

</xsl:stylesheet>