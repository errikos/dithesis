% dithesis.cls
%
% A LaTeX2e document class for writing MSc theses in English for the Department
% of Informatics and Telecommunications (DI&T) of the National and Kapodistrian
% University of Athens (NKUA).
%
% Copyright (c) 2014, 2015 Charalampos S. Nikolaou <charnik@di.uoa.gr>
%                     2017 Ergys Dona <errikosd@gmail.com>
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt.
%
% This work consists of the following files:
% dithesis.cls
%		This document class file
%
% sample.tex
%		A sample document demonstrating the use of this class file
%
% emblems/
%		A directory containing three colored versions of the official emblem of
%		the National and Kapodistrian University of Athens.
%
% fonts/
%		A directory containing the Arial family TrueType fonts. The directory
%		also includes a README file with instructions on installing the fonts
%		in your system (assuming Unix-based).

% Document Class Options
%
% inscr
% 		If present, then a page with the inscription provided via the command
% 		\inscription{} is printed.
%
% ack
%		If present, then a page with the acknowledgements provided via the
%		command \acksEn{} is printed.
%
% preface
%		If present, then a preface page is included just before the
%		introductory chapter. The content of this page is controled via the
%		command \preface{}.
%
% lop
%		If present, then a page with the list of puclications will be included.
%

% Document Versions
%
% Version 1.2, 2017/02/26
%   Refactored the document to allow it to be used to write BSc Theses.
%
% Version 1.1, 2015/11/06
%		Updated document class so as to be compatible with the template file
%		regarding the appearance of headers/footers and appendix names. Require
%		also package `longtable' for being used for abbreviations/acronyms.
%
% Version 1.0, 2014/12/08
%		Initial attempt at creating the first class file for LaTeX Theses in
%		DI&T, NKUA.

% Known Issues
%
% * Chapter titles are not appearing in capital letters in the ToC, although
%   in other places this has been taken care of for good. Thus, one is enforced
%   to type chapter titles in capital letters, so as to be compatible with the
%   requirements of the department.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dithesis}[2017/02/26 v1.2 LaTeX class for BSc Theses
submitted to the Department of Informatics and Telecommunications of the
National and Kapodistrian University of Athens]

%
% Declare and initialize global ifs
% (set by passing options to this document class)
%

% controls the inclusion of the inscription page
\newif\ifinscriptionpage
\inscriptionpagefalse

% controls inclusion of acknowledgement page
\newif\ifackpage
\ackpagefalse

% controls inclusion of the list of publications page
\newif\ifloppage
\loppagefalse

% controls inclusion of the preface page
\newif\ifprefacepage
\prefacepagefalse

%
% Declare and initialize internal ifs (not set by document class options)
%
\newif\ifenglishfrontpage
\englishfrontpagefalse

\newif\ifenglishcommitteepage
\englishcommitteepagefalse

% marks whether the appendices have started
% (used later for setting an appropriate naming scheme for the appendix title)
\newif\ifappendixstarted
\appendixstartedfalse

% controls whether we want to print dual-page or single page
% when enabled, the page numbering will occur in the centre of the page
% otherwise, it will occur at the right
\newif\ifdualpage
\dualpagefalse

%
% Check passed options
%
\DeclareOption{inscr}{
  \inscriptionpagetrue
}
\DeclareOption{ack}{
  \ackpagetrue
}
\DeclareOption{preface}{
  \prefacepagetrue
}
\DeclareOption{lop}{
  \loppagetrue
}
\DeclareOption{dualpage}{
  \dualpagetrue
}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[12pt,oneside]{book}

%
% Required packages and configuration
%
\RequirePackage[a4paper,
top=2cm,bottom=2cm,bindingoffset=0.5cm,left=2cm,right=2cm,
headsep=0.5cm,footskip=0.75cm,
]{geometry} % add option showframe=true for debugging
\RequirePackage{fancyhdr}
\RequirePackage[final]{graphicx}
\RequirePackage{sectsty}   % needed for formatting chapter headings
\RequirePackage{textcase}  % needed for forcing capital letters (in chapters)
\RequirePackage[resetlabels]{multibib}
%\usepackage[notlof,notlot,nottoc,notlop]{tocbibind}
%\RequirePackage{tocloft}  % needed for making chapter titles upper case
\RequirePackage{etoolbox}  % needed for patchcmd
\RequirePackage{tabularx}  % needed for tabular* environment
\RequirePackage{longtable} % needed for splitting big tables across pages
\RequirePackage{xifthen}

%(e.g., abbreviations)
%\RequirePackage[toc,page,titletoc]{appendix} % needed for configuring
%%appendices

%
% Add Greek support
%
\usepackage{fontspec}
\usepackage{xunicode}
\usepackage{xltxtra}
\usepackage{polyglossia}
\newfontfamily\greekfont[Script=Greek]{Arial}
\setdefaultlanguage[variant=uk]{english}
\setotherlanguage{greek}

%
% Set font mamily Aria
%
\setmainfont[Ligatures={Common,TeX}]{Arial} % the passed option was needed for
                                            % correctly rendering double quotes
\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\setsansfont[Mapping=tex-text,Scale=MatchLowercase]{Arial}

%\ifglossaryInPreamble
%\RequirePackage[toc,section=chapter,numberedsection=false,nonumberlist]{glossaries}
%\else
% \RequirePackage[toc,section,numberedsection=nolabel,nonumberlist]{glossaries}
%\fi
%\makeglossaries

\providecommand{\grnumm}[1]{#1\textsuperscript{ο}}
\providecommand{\grnumf}[1]{#1\textsuperscript{η}}

%
% Commands for first, middle, and last name (greek and english versions)
%
\providecommand{\authorFirstGr}[1]{\gdef\@authorFirstGr{#1}}
\providecommand{\authorFirstAbrGr}[1]{\gdef\@authorFirstAbrGr{#1}}
\providecommand{\authorMiddleGr}[1]{\gdef\@authorMiddleGr{#1}}
\providecommand{\authorLastGr}[1]{\gdef\@authorLastGr{#1}}
\providecommand{\authorFirstEn}[1]{\gdef\@authorFirstEn{#1}}
\providecommand{\authorFirstAbrEn}[1]{\gdef\@authorFirstAbrEn{#1}}
\providecommand{\authorMiddleEn}[1]{\gdef\@authorMiddleEn{#1}}
\providecommand{\authorLastEn}[1]{\gdef\@authorLastEn{#1}}
\providecommand{\authorSn}[1]{\gdef\@authorSn{#1}}

%
% Commands for the title of the thesis (greek and english versions)
%
\providecommand{\titleGr}[1]{\gdef\@titleGr{#1}}
\providecommand{\titleEn}[1]{\gdef\@titleEn{#1}}

%
% Commands for the date of the writing of the thesis (Month followed by Year)
% [provide greek and english versions]
%
\providecommand{\dateGr}[1]{\gdef\@dateGr{#1}}
\providecommand{\dateEn}[1]{\gdef\@dateEn{#1}}


%
% Commands for supervisor(s)
% If more than one supervisor is declared, the class takes care to show
% "Supervisors" instead of "Supervisor" and
% "Επιβλέποντες" instead of "Επιβλέπων".
%
\gdef\@supervisorLabelSuffixGr{ων}
\gdef\@supervisorLabelSuffixEn{}

\providecommand{\supervisorGr}[2]{%
  \ifthenelse{\isundefined{\@thesupervisorslistGr}}{%
    \def\@thesupervisorslistGr{\textbf{#1,} #2}
  }{%
    \g@addto@macro\@thesupervisorslistGr{\\&\textbf{#1,} #2}
    \def\@supervisorLabelSuffixGr{οντες}
  }
}

\providecommand{\supervisorEn}[2]{%
  \ifthenelse{\isundefined{\@thesupervisorslistEn}}{%
    \def\@thesupervisorslistEn{\textbf{#1,} #2}
  }{%
    \g@addto@macro\@thesupervisorslistEn{\\&\textbf{#1,} #2}
    \def\@supervisorLabelSuffixEn{s}
  }
}

%
% Commands for setting up abstract (greek and english versions), ack (english
% version), synopsis (greek version only), incsriptionEn (english version
%only), and prefaceEn (english version only) pages
%
\providecommand{\abstractEn}[1]{\gdef\@abstractEn{#1}}
\providecommand{\abstractGr}[1]{\gdef\@abstractGr{#1}}
\providecommand{\synopsisGr}[1]{\gdef\@synopsisGr{#1}}
\providecommand{\acksEn}[1]{\gdef\@acksEn{#1}}
\providecommand{\inscriptionEn}[1]{\gdef\@inscriptionEn{%
\vspace*{0.2\textheight}
\begin{flushright}
#1
\end{flushright}
}}
\providecommand{\prefaceEn}[1]{\gdef\@prefaceEn{#1}}

%
% Commands for Subject Area and Keywords fields
% (greek and english versions)
%
\providecommand{\subjectAreaGr}[1]{\gdef\@subjectAreaGr{#1}}
\providecommand{\subjectAreaEn}[1]{\gdef\@subjectAreaEn{#1}}
\providecommand{\keywordsGr}[1]{\gdef\@keywordsGr{#1}}
\providecommand{\keywordsEn}[1]{\gdef\@keywordsEn{#1}}

%
% Command for specifiying the file containing the publications
% in the context of the PhD - NOT USED FOR BSC THESES.
%
\providecommand{\lopfile}[1]{\newcites{lop}{List of
publications}\gdef\@lopfileinternal{#1}}

%
% Command for starting a new unumbered chapter (ToC'ed) for
% holding the table of abbreviations and acronyms. The table
% should be set by the user.
%
\providecommand{\abbreviations}{
  \chapter*{ABBREVIATIONS - ACRONYMS}
  \addcontentsline{toc}{chapter}{ABBREVIATIONS - ACRONYMS}
}

%
% Front page (greek and english versions)
%
\def\@frontpage{
\begin{center}
\includegraphics[scale=0.85]{emblems/athena-black}
\end{center}
\begin{minipage}[t]{\textwidth}
    \begin{center}
      {\large \bfseries
      \ifenglishfrontpage
      	NATIONAL AND KAPODISTRIAN UNIVERSITY OF ATHENS
      \else
      	ΕΘΝΙΚΟ ΚΑΙ ΚΑΠΟΔΙΣΤΡΙΑΚΟ ΠΑΝΕΠΙΣΤΗΜΙΟ ΑΘΗΝΩΝ
      \fi
      }
      \linebreak

      {\bfseries
      \ifenglishfrontpage
      	SCHOOL OF SCIENCES \\ DEPARTMENT OF INFORMATICS AND TELECOMMUNICATIONS
      \else
      	ΣΧΟΛΗ ΘΕΤΙΚΩΝ ΕΠΙΣΤΗΜΩΝ \\ ΤΜΗΜΑ  ΠΛΗΡΟΦΟΡΙΚΗΣ ΚΑΙ ΤΗΛΕΠΙΚΟΙΝΩΝΙΩΝ
      \fi
      }
      \linebreak\linebreak\linebreak\linebreak\linebreak

      {\bfseries
      \ifenglishfrontpage
      	BSc THESIS
      \else
      	ΠΤΥΧΙΑΚΗ ΕΡΓΑΣΙΑ
      \fi}
      \linebreak\linebreak

      {\Large \bfseries
      \ifenglishfrontpage
      	\@titleEn
      \else
      	\@titleGr
      \fi}
      \linebreak\linebreak\linebreak

      {\bfseries
      \ifenglishfrontpage
	  	  \@authorFirstEn{} \@authorMiddleEn{} \@authorLastEn
	    \else
	  	  \@authorFirstGr{} \@authorMiddleGr{} \@authorLastGr
	    \fi}
      \linebreak\linebreak\linebreak
      \linebreak\linebreak\linebreak
      \linebreak\linebreak
    \end{center}
    {
    \ifenglishfrontpage
      \begin{tabular}{l l}
        \textbf{Supervisor\@supervisorLabelSuffixEn:} & \@thesupervisorslistEn \\
      \end{tabular}
    \else
      \begin{tabular}{l l}
        \textbf{Επιβλέπ\@supervisorLabelSuffixGr:} & \@thesupervisorslistGr \\
      \end{tabular}
    \fi
    }
\end{minipage}
    \vfill
    \begin{center}
    {\bfseries
    \ifenglishfrontpage
      ATHENS
    \else
      ΑΘΗΝΑ
    \fi}
    \\\vspace*{4mm}
    {\bfseries
    \ifenglishfrontpage
      \@dateEn
    \else
      \@dateGr
    \fi}
    \end{center}
    \clearpage
}

%
% Committee page (greek and english versions)
%
\def\@committeepage{
    \begin{center}
    \vspace*{1.5cm}
    {\bfseries
    \ifenglishcommitteepage
    	BSc THESIS
    \else
    	ΠΤΥΧΙΑΚΗ ΕΡΓΑΣΙΑ
    \fi
    }
    \linebreak

    {
    \ifenglishcommitteepage
    	\@titleEn
    \else
    	\@titleGr
    \fi
    }
    \linebreak\linebreak\linebreak

    {\bfseries
    \ifenglishcommitteepage
    	\@authorFirstEn{} \@authorMiddleEn{} \@authorLastEn
    \else
    	\@authorFirstGr{} \@authorMiddleGr{} \@authorLastGr
    \fi
    \vspace{2mm}
    }
    \linebreak
    {
    \ifenglishcommitteepage
    	{\bfseries S.N.:} \@authorSn
    \else
    	{\bfseries Α.Μ.:} \@authorSn
    \fi
    }
    \linebreak\linebreak\linebreak
    \linebreak\linebreak\linebreak
    \linebreak\linebreak\linebreak
    \linebreak\linebreak\linebreak
    \linebreak\linebreak
    \end{center}

    {
    \ifenglishcommitteepage
      \begin{tabular}{l l}
        \textbf{SUPERVISOR\MakeUppercase{\@supervisorLabelSuffixEn:}} & \@thesupervisorslistEn \\
      \end{tabular}
      % \@supervisorlabelEn
    \else
      \begin{tabular}{l l}
        \textbf{ΕΠΙΒΛΕΠ\MakeUppercase{\@supervisorLabelSuffixGr:}} & \@thesupervisorslistGr \\
      \end{tabular}
      % \@supervisorlabelGr
    \fi
    }
    \clearpage
}

%
% Abstract (english version)
%
\def\@absEn{
  \chapter*{Abstract}
  \thispagestyle{empty}
  \@abstractEn{}
  \vfill

  {\bfseries SUBJECT AREA}: \@subjectAreaEn\\

  {\bfseries KEYWORDS}: \@keywordsEn
}

%
% Abstract (greek version)
%
\def\@absGr{
  \chapter*{ΠΕΡΙΛΗΨΗ}
  \thispagestyle{empty}
  \@abstractGr{}
  \vfill

  {\bfseries ΘΕΜΑΤΙΚΗ ΠΕΡΙΟΧΗ}: \@subjectAreaGr\\

  {\bfseries ΛΕΞΕΙΣ ΚΛΕΙΔΙΑ}: \@keywordsGr
}

%
% Greek synopsis of the thesis
%
\def\@synopsis{
  \chapter*{ΣΥΝΟΠΤΙΚΗ ΠΑΡΟΥΣΙΑΣΗ ΤΗΣ ΔΙΔΑΚΤΟΡΙΚΗΣ ΔΙΑΤΡΙΒΗΣ}
  \thispagestyle{empty}
  \@synopsisGr{}
  \clearpage
}

%
% Inscription page (optional)
%
% Enable it by passing option ``inscr'' to the document class.
%
\def\@inscr{
  \cleardoublepage
  \@inscriptionEn{}
  \clearpage
}

%
% Acknowledgements (optional)
%
% Enable it by passing option ``ack'' to the document class.
%
\def\@acks{
  \chapter*{Acknowledgements}
  \thispagestyle{empty}
  \@acksEn{}
  \clearpage
}

%
% Preface page (optional)
%
% Enable it by passing option ``preface'' to the document class.
%
% Check the following page that gives a definition among the uses of Prologue,
% Foreword, and Preface:
%http://iankingsleyauthor.blogspot.de/2013/03/defined-prologue-epilogue-foreword.html.
%
\def\@preface{
  \chapter*{Preface}
  \thispagestyle{empty}
  \@prefaceEn{}
  \clearpage
}

%
% List of publications (optional)
%
% Enable it by passing option ``lop'' to the document class.
%
\def\@listofpubs{
  \bibliographystylelop{unsrt}
  \bibliographylop{\@lopfileinternal}
  \thispagestyle{empty}
  \clearpage
}

%
% Configure the frontmatter page
%
\renewcommand{\frontmatter}{
    \pagestyle{empty}
    % frontpage - english version
    \englishfrontpagetrue
    \@frontpage

    % frontpage - greek version
    \englishfrontpagefalse
    \@frontpage

    % examination committe page - english version
    \englishcommitteepagetrue
    \@committeepage

    % examination committe page - greek version
    \englishcommitteepagefalse
    \@committeepage

    % abstract (english and greek version)
    \@absEn
    \@absGr

    % inscription
    \ifinscriptionpage
      \@inscr
    \fi

    % acknowledgements (english version only, OPTIONAL)
    \ifackpage
    	\@acks
    \fi

    % table of contents
    % add TOC as bookmark
    \addtocontents{toc}{\protect{\pdfbookmark[0]{CONTENTS}{toc}}}
    \tableofcontents

    % list of figures
    %\listoffigures
    %\thispagestyle{empty}
    \cleardoublepage
    \begingroup
    \makeatletter
    \let\ps@plain\ps@empty
    \makeatother

    \pagestyle{empty}
    \listoffigures
    \cleardoublepage
    \endgroup

    % list of tables
    \listoftables
    \thispagestyle{empty}

    % preface page (english version only, OPTIONAL)
    \ifprefacepage
	    \@preface
    \fi

    % Prepare things for the rest of the document
    \clearpage
    \thispagestyle{empty}
}

%
% Configure the mainmatter and backmatter pages
%
\renewcommand{\mainmatter}{
	% just set the style of the pages to be fancy
    \pagestyle{fancy}
}
\renewcommand{\backmatter}{
	% just set the style of the pages to be fancy
    \pagestyle{fancy}

    % and also, make the empty page style permanent, since
    % when a \chapter command is invoked, the command
    % \thispagestyle{plain} is invoked
    % (thanks to http://tex.stackexchange.com/a/19741)
    %\patchcmd{\chapter}{plain}{empty}{}{}
}

%
% Configure chapter printing and alignment (centered)
%
\def\@makechapterhead#1{%
  %\vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \interlinepenalty\@M
    \ifappendixstarted
       \large \centering \bfseries APPENDIX \thechapter. \MakeTextUppercase{#1}
    \else
	   \large \centering \bfseries \thechapter. \MakeTextUppercase{#1}
    \fi
    \par\nobreak
    \vskip 20\p@
  }}

\chaptertitlefont{\vspace*{-2.38cm} \large \centering \MakeTextUppercase}
\sectionfont{\normalsize}
\subsectionfont{\normalsize}
\subsubsectionfont{\normalsize}
\paragraphfont{\normalsize}
\subparagraphfont{\normalsize}

% use capital letters for chapters in the ToC as well
% TODO

%
% Rename Bibliography to References
%
\renewcommand{\bibname}{REFERENCES}

%
% Set ToC depth
%
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{3}

%
% No indentation for paragraphs
%
\setlength{\parindent}{0pt}

%
% Paragraph spacing should be
%
\setlength{\parskip}{6pt}

%
% Line spacing should be one line
%
\linespread{1}

%
% Configure header and footer
%
%\pagestyle{fancy}
\fancyhf{}
\fancyhead[LEO]{{\scriptsize \@titleEn{}}}
\ifdualpage
\fancyfoot[C]{{\fontsize{10pt}{10pt}\selectfont \thepage}}
\else
\fancyfoot[R]{{\fontsize{10pt}{10pt}\selectfont \thepage}}
\fi
\fancyfoot[LE,LO]{{\scriptsize \@authorFirstAbrEn{} \@authorLastEn{}}}

% needed redefinition, because commands like \chapter call
% \thispagestyle{plain} automatically
\fancypagestyle{plain} {
  \fancyhf{}
  \fancyhead[LO]{{\scriptsize \@titleEn{}}}
  \ifdualpage
  \fancyfoot[C]{{\fontsize{10pt}{10pt}\selectfont \thepage}}
  \else
  \fancyfoot[R]{{\fontsize{10pt}{10pt}\selectfont \thepage}}
  \fi
  \fancyfoot[LE,LO]{{\scriptsize \@authorFirstAbrEn{} \@authorLastEn{}}}
}
\renewcommand{\headrulewidth}{0pt}

%
% Configure the first page of ToC to have an empty pagestyle
% (thanks to http://tex.stackexchange.com/a/5789)
%
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}
