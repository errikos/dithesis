%%
%% dithesis.cls version 0.2
%% dithesis - Latex2e document class for undergraduate theses at the Department
%%            of Informatics and Telecommunications, University of Athens.
%% Copyright (C) 2011-12 Yannis Mantzouratos <mantzouratos@gmail.com>
%%
%% LICENSE:
%%
%% This work may be distributed and/or modified under the conditions of the
%% LaTeX Project Public License, either version 1.3 of this license or (at
%% your option) any later version.
%%
%% The latest version of this license is in:
%% http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status "maintained".
%% The Current Maintainer of this work is Yannis Mantzouratos.
%%
%% This work consists of the source file dithesis.cls and the documentation
%% files sample.tex, samplewArial.tex, sample.pdf and samplewArial.pdf.
%% To ensure proper compilation, however, the logo of the University of Athens
%% is also distributed alongside this work, under the filename athena-black.pdf.
%%
%% NOTES and WARRANTY:
%%
%% This work conforms to the requirements of the Department of Informatics and
%% Telecommunications at the University of Athens regarding the preparation of
%% undergraduate theses, as of Sep 1, 2011.
%%
%% This work is distributed in the hope that it will be useful, but WITHOUT ANY
%% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
%% FOR A PARTICULAR PURPOSE.
%% The entire risk as to the quality and performance of this work is with you.
%% Should this work prove defective, you assume the cost of all necessary
%% servicing, repair, or correction.
%% See the LaTeX Project Public License for more details.
%%
%% The latest official Microsoft Word(...) template can be found in
%% http://www.di.uoa.gr/lib.
%%
%% CHANGELOG:
%%
%% version 0.2:
%% - Fixed pagestyle inconsistencies for multi-page Table of Contents, List of
%%   Figures, List of Tables, as well as the thesis prologue, acknowledgments,
%%   dedication, and abstract environments.
%% - Fixed spacing between the title and entries of List of Figures and List of
%%   Tables; the spacing between entries is now the same for sections, figures
%%   and tables, too.
%% - Fixed line spacing between different bibliography entries to zero.
%% - Added explicit enforcement of 12pt entries in List of Figures and List of
%%   Tables.
%%

%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{dithesis}[2011/09/01 v0.2 DIT.UoA Undergraduate Thesis LaTeX
  document class]

\LoadClass[a4paper,titlepage,oneside,12pt]{article}[2005/09/16]
%% ============================================================

%%
%% User Interface Commands
%%
% \thesistitle{text}: set the title of thesis to text
% \thethesistitle:    access the title of thesis later in the document
\DeclareRobustCommand{\thesistitle}[1]{\title{#1}\let\thethesistitle\thetitle}
% \thesissection{title}:  set a new numbered section of thesis, with some title
% \thesissection*{title}: similar to \thesissection, but produces an unnumbered
%                         section, which will be included in the ToC.
\makeatletter
\DeclareRobustCommand{\thesissection}{%
  \@ifstar\thesissectionstar\thesissectionnostar
}
\makeatother
\newcommand{\thesissectionstar}[1]{%
  \newpage
  \phantomsection
  \addcontentsline{toc}{section}{\texorpdfstring{\MakeUppercase{#1}}{#1}}
  \section*{#1}
}
\newcommand{\thesissectionnostar}[1]{%
  \newpage
  \section[\texorpdfstring{\MakeUppercase{#1}}{#1}]{#1}%
}
% \thesissubsection,    \thesissubsection*
% \thesissubsubsection, \thesissubsubsection*
% all like before.
\makeatletter
\DeclareRobustCommand{\thesissubsection}{%
  \@ifstar\thesissubsectionstar\thesissubsectionnostar
}
\makeatother
\newcommand{\thesissubsectionstar}[1]{%
  \phantomsection
  \addcontentsline{toc}{subsection}{#1}
  \subsection*{#1}
}
\newcommand{\thesissubsectionnostar}[1]{%
  \subsection{#1}
}
\makeatletter
\DeclareRobustCommand{\thesissubsubsection}{%
  \@ifstar\thesissubsubsectionstar\thesissubsubsectionnostar
}
\makeatother
\newcommand{\thesissubsubsectionstar}[1]{%
  \phantomsection
  \addcontentsline{toc}{subsubsection}{#1}
  \subsubsection*{#1}
}
\newcommand{\thesissubsubsectionnostar}[1]{%
  \subsubsection{#1}
}

% \thesiskeywords{SAlabel}{SA}{KWlabel}{KW}{KW}{KW}{KW}{KW}:
%     set the Subject Area label, the Subject Area, the Keyword label and
%     five keywords, respectively, at the end of the current page.
\DeclareRobustCommand{\thesiskeywords}[8]{%
  \vfill
  \begin{tabularx}{\textwidth}{l X}
    {\bfseries\MakeUppercase{#1}:}  & #2
  \end{tabularx}

  \begin{tabularx}{\textwidth}{l X}
    {\bfseries\MakeUppercase{#3}:}  & \MakeLowercase{#4, #5, #6, #7, #8}
  \end{tabularx}

}

% \university:      the name of university
% \school:          the name of school
% \department:      the name of the department
% \thesislabel:     how to label the thesis (do NOT confuse with title)
% \supervisorlabel: how to label the supervisor(s)
% \idlabel:         how to label the ID of the author(s)
% \thesisplace:     the place where the thesis was deemed successfully completed
% \thesisdate:      the date when the thesis was successfully completed
\newcommand{\university}{National and Kapodistrian University of Athens}
\newcommand{\school}{School of Science}
\newcommand{\department}{Department of Informatics and Telecommunications}
\newcommand{\thesislabel}{Thesis}
\newcommand{\supervisorlabel}{Supervisors}
\newcommand{\idlabel}{A.M.}
\newcommand{\thesisplace}{Athens}
\newcommand{\thesisdate}{September 2011}

% \thesisauthor{Name}{ID}: set the author of the thesis; their name is Name and
%                          their departmental identification number is ID.
% for multiple authors, just use the \thesisauthor command multiple times.
% relative ordering is preserved.
% \thethesisauthor:        access the author(s) of the thesis, as a list of
%                          comma-separated values.
\makeatletter
\newcommand{\thesisauthor}[2]{%
  \ifthenelse{\isundefined{\theauthorsattitlepage}}{%
    \def\theauthorsattitlepage{#1}
  }%
  {%
    \g@addto@macro\theauthorsattitlepage{\\#1}
  }
  \ifthenelse{\isundefined{\theauthorsatacceptancepage}}{%
    \def\theauthorsatacceptancepage{\textbf{#1}\\\textbf{\idlabel:} #2}
  }%
  {%
    \g@addto@macro\theauthorsatacceptancepage{%
      \\\textbf{#1}\\\textbf{\idlabel:} #2}
  }
  \ifthenelse{\isundefined{\theauthorsatfooters}}{%
    \def\theauthorsatfooters{#1}
  }%
  {%
    \g@addto@macro\theauthorsatfooters{, #1}
  }
}
\makeatother
\newcommand{\thethesisauthor}{\theauthorsatfooters}

% \supervisor{Name}{Profession}: set the supervisor of the thesis; their name is
%                                Name and their profession is indicated by
%                                Profession (e.g. Professor, PhD Student, etc).
% for multiple supervisors, just use the \supervisor command multiple times.
% relative ordering is preserved.
\makeatletter
\newcommand{\supervisor}[2]{%
  \ifthenelse{\isundefined{\thesupervisorslist}}{%
    \def\thesupervisorslist{\textbf{#1,} #2}
  }%
  {%
    \g@addto@macro\thesupervisorslist{\\&\textbf{#1,} #2}
  }
}
\makeatother

\newcommand{\thesupervisorsattitlepage}{%
  \begin{table*}[!h]
    \centering
    \begin{tabular}{l l}
      \textbf{\supervisorlabel:} & \thesupervisorslist \\
    \end{tabular}
  \end{table*}
}

\newcommand{\thesupervisorsatacceptancepage}{%
  \begin{table*}[!h]
    \centering
    \begin{tabular}{l l}
      \textbf{\MakeUppercase{\supervisorlabel:}} & \thesupervisorslist \\
    \end{tabular}
  \end{table*}
}
%%
%% End of User Interface Commands
%% ============================================================

%%
%% User Interface Environments
%%
% the following are self explanatory.
% thesisabstract:         the abstract title is parameterized
% thesisdedication
% thesisacknowledgments:  the acknowledgments title is parameterized
% thesisprologue:         the prologue title is parameterized
% thesisterminology:      the terminology title is parameterized
% thesisabbreviations:    the abbreviations title is parameterized
% thesisbibliography[]{}: wrapper of thebibliography, where the (optional)
%                         references title is parameterized
\newenvironment{thesisabstract}[1][Abstract]
               { \newpage
                 \pagestyle{empty}
                 \section*{#1}
                 \vspace*{0.3in}}
               {\clearpage\pagestyle{fancy}}

\newenvironment{thesisdedication}
               { \newpage
                 \pagestyle{empty}
                 \vspace*{3.5in}
                 \begin{flushright}
                   \fontsize{12pt}{14.4pt}\selectfont\itshape}
               { \end{flushright}\clearpage\pagestyle{fancy}}

\newenvironment{thesisacknowledgments}[1][Acknowledgements]
               { \newpage
                 \pagestyle{empty}
                 \section*{#1}
                 \vspace*{0.3in}}
               {\clearpage\pagestyle{fancy}}

\newenvironment{thesisprologue}[1][Prologue]
               { \thesissection*{#1}
                 \pagestyle{empty}}
               {\clearpage\pagestyle{fancy}}

\newenvironment{thesisterminology}[1][Terminology Table]
               { \thesissection*{#1}}
               {}

\newenvironment{thesisabbreviations}[1][Abbreviations, Initials and Acronyms]
               { \thesissection*{#1}}
               {}

\let\oldrefname\refname
\newenvironment{thesisbibliography}[2][\oldrefname]
               { \renewcommand{\refname}{#1}
                 \newpage
                 \phantomsection
                 \addcontentsline{toc}{section}%
                                 {\texorpdfstring{\MakeUppercase{#1}}{#1}}
                 \begin{thebibliography}{#2}
                   \fontsize{10pt}{12pt}\selectfont}
               { \end{thebibliography}}
%%
%% End of User Interface Environments
%% ============================================================

%%
%% General Packages
%%
\RequirePackage{hyperref} % In-text references
\RequirePackage{tabularx} % Special tables
%%
%% End of General Packages
%% ============================================================

%%
%% Figures, Subfigures and Captions
%%
\RequirePackage{graphicx}              % To include graphics
\RequirePackage{float}                 % Figures
\RequirePackage[caption=false]{subfig} % Subfigures
\RequirePackage[%
  justification=centering,
  labelsep=colon,
  figureposition=bottom,
  tableposition=top]{caption}          % Captions

% caption fonts should be boldface 10pt.
\renewcommand{\captionfont}{\fontsize{10pt}{12pt}\selectfont\bfseries}
%%
%% End of Figures, Subfigures and Captions
%% ============================================================

%%
%% Margins of Text Pages
%%
\RequirePackage[%
  a4paper,
  top=2cm,   bottom=2cm,     left=2cm,    right=2cm, bindingoffset=0.5cm,
  head=14pt, headsep=0.50cm, foot=0.75cm]{geometry}
%%
%% End of Margins of Text Pages
%% ============================================================

%%
%% Paragraph and Line Spacing
%%
\RequirePackage{parskip}                  % Paragraphs
\RequirePackage[onehalfspacing]{setspace} % Lines

% Indentation preceeding a paragraph should be 0 pt, and vertical space after
% a paragraph should be 6 pt.
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt}

% The following excerpt redefines thebibliography in order to achieve zero line
% spacing between different bibliography items.
% It is a copy of bibspacing.sty by Jakob Schiotz [dcwww.camd.dtu.dk/~schiotz/],
% self-contained for ease of use.
% Retrieved date: Sep 1, 2012.
\makeatletter
\newdimen\bibindent
\setlength\bibindent{1.5em}
\renewenvironment{thebibliography}[1]{%
  \section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
         \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep\z@skip
            \parsep\z@skip
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\makeatother
% End of bibspacing.sty.
%%
%% End of Paragraph and Line Spacing
%% ============================================================

%%
%% Headers and Footers of Text Pages
%%
\RequirePackage{fancyhdr}

% each page should have a left header with the thesis title at 8 pt, a left
% footer with the names of authors at 8 pt, and a right footer with the current
% page number at 10 pt.
\pagestyle{fancy}
\fancyhead[R]{}
\fancyhead[C]{}
\fancyhead[L]{\fontsize{8pt}{9.6pt}\selectfont\thethesistitle}
\fancyfoot[R]{\fontsize{10pt}{12pt}\selectfont\thepage}
\fancyfoot[C]{}
\fancyfoot[L]{\fontsize{8pt}{9.6pt}\selectfont\theauthorsatfooters}
\renewcommand{\headrulewidth}{0pt}
%%
%% End of Headers and Footers of Text Pages
%% ============================================================

%%
%% Format of Titles for Thesis Sections, Subsections and Subsubsections.
%%
\RequirePackage{titlesec}

% sections should be boldfaced, uppercase and centered, at 14pt, with no
% further spacing near them.
\titleformat{\section}[block]
            {\fontsize{14pt}{16.8pt}\selectfont\centering\bfseries}
            {\thesection . }{0pt}{\MakeUppercase}
\titlespacing{\section}{0pt}{0pt}{0pt}
% subsections should be boldfaced and justified at left, at 12pt, with
% 12pt vertical spacing before them.
\titleformat{\subsection}[block]
            {\fontsize{12pt}{14.4pt}\selectfont\raggedright\bfseries}
            {\thesubsection\quad}{0pt}{}
\titlespacing{\subsection}{0pt}{12pt}{0pt}
% subsubsections should be boldfaced and justified at left, at 12pt, with
% 12pt vertical spacing before them.
\titleformat{\subsubsection}[block]
            {\fontsize{12pt}{14.4pt}\selectfont\raggedright\bfseries}
            {\thesubsubsection\quad}{0pt}{}
\titlespacing{\subsubsection}{0pt}{12pt}{0pt}
%%
%% End of Format of Titles for Thesis Sections, Subsections and Subsubsections.
%% ============================================================

%%
%% Format of Table of Contents, List of Figures and List of Tables.
%%
\RequirePackage{titletoc}
\RequirePackage[subfigure,titles]{tocloft}

% Table of Contents
\let\oldtableofcontents\tableofcontents
\DeclareRobustCommand{\tableofcontents}{
  \newpage
  \pagestyle{empty}
  \oldtableofcontents
  \clearpage
  \pagestyle{fancy}
}

% place dots between each section and the respective page number
\renewcommand{\cftsecleader}{\bfseries\cftdotfill{\cftdotsep}}
% place dots between each subsection and the respective page number
\renewcommand{\cftsubsecleader}{\bfseries\cftdotfill{\cftdotsep}}
% place a dot after each section number
\renewcommand{\cftsecaftersnum}{.}
% section entries should be 12 pt and bold
\renewcommand{\cftsecfont}{\fontsize{12pt}{14.4pt}\selectfont\bfseries}
% subsection entries should be 10 pt
\renewcommand{\cftsubsecfont}{\fontsize{10pt}{12pt}\selectfont\bfseries}
% subsubsection entries should be 10 pt
\renewcommand{\cftsubsubsecfont}{\fontsize{10pt}{12pt}\selectfont}
% subsections should not be indented, whereas subsubsections should
\setlength\cftsubsubsecindent\cftsubsecindent
\setlength{\cftsubsecindent}{0pt}
% subsections should have the same vertical space with sections
\setlength\cftbeforesubsecskip\cftbeforesecskip
% space between sections and numbering in case of double digit numbers
\newlength{\tocbinnumwidth}
\settowidth{\tocbinnumwidth}{9}
\addtolength{\cftsecnumwidth}{\tocbinnumwidth}

% List of Figures
\let\oldlistoffigures\listoffigures
\DeclareRobustCommand{\listoffigures}{
  \newpage
  \pagestyle{empty}
  \oldlistoffigures
  \clearpage
  \pagestyle{fancy}
}
% place ``Figure x:'' labels in front of each figure
\newlength{\figlabelwidth}
\renewcommand{\cftfigpresnum}{\figurename\enspace}
\renewcommand{\cftfigaftersnum}{:}
\settowidth{\figlabelwidth}{\cftfigpresnum\cftfigaftersnum}
\addtolength{\cftfignumwidth}{\figlabelwidth}
% explicitly enforce 12pt fonts
\renewcommand{\cftfigfont}{\fontsize{12pt}{14.4pt}\selectfont}
% and make the spacing the same as with sections
\setlength\cftbeforefigskip\cftbeforesecskip

% List of Tables
\let\oldlistoftables\listoftables
\DeclareRobustCommand{\listoftables}{
  \newpage
  \pagestyle{empty}
  \oldlistoftables
  \clearpage
  \pagestyle{fancy}
}
% place ``Table x:'' labels in front of each table
\newlength{\tablabelwidth}
\renewcommand{\cfttabpresnum}{\tablename\enspace}
\renewcommand{\cfttabaftersnum}{:}
\settowidth{\tablabelwidth}{\cfttabpresnum\cfttabaftersnum}
\addtolength{\cfttabnumwidth}{\tablabelwidth}
% explicitly enforce 12pt fonts
\renewcommand{\cfttabfont}{\fontsize{12pt}{14.4pt}\selectfont}
% and make the spacing the same as with sections
\setlength\cftbeforefigskip\cftbeforesecskip
%%
%% End of Format of Table of Contents, List of Figures and List of Tables.
%% ============================================================

%%
%% Format of the Title and Acceptance Pages
%%
\RequirePackage{titling}
\RequirePackage{xifthen}

% the logo should exist to go on.
\IfFileExists{athena-black.pdf}{}{
  \ClassError{dithesis}{The University of Athens logo athena-black.pdf was not found.}
             {Add athena-black.pdf in the class folder and try again.}
}

% maketitle modifications (refer to the titling package)
\setlength{\droptitle}{-204pt}
\renewcommand{\maketitlehooka}{%
  \begin{center}
    \begin{singlespace}
      \includegraphics[height=2cm]{athena-black.pdf}
      \vspace*{0.08in}

      {\fontsize{14pt}{16.8pt}\selectfont\bfseries
        \MakeUppercase{\university}}

      \vspace*{0.08in}

      {\fontsize{12pt}{14.4pt}\selectfont\bfseries
        \MakeUppercase{\school}} \\
      {\fontsize{12pt}{14.4pt}\selectfont\bfseries
        \MakeUppercase{\department}}

      \vspace*{0.82in}

      {\fontsize{12pt}{14.4pt}\selectfont\bfseries
        \MakeUppercase{\thesislabel}}

      \vspace*{0.25in}
    \end{singlespace}
  \end{center}
}

\pretitle{%
  \begin{center}
    \begin{singlespace}
      \fontsize{16pt}{19.2pt}\selectfont\bfseries}
\posttitle{\end{singlespace}\end{center}}

\renewcommand{\maketitlehookb}{%
  \vspace*{0.43in}
}

\preauthor{%
  \author{\theauthorsattitlepage}
  \begin{center}
    \begin{singlespace}
      \fontsize{12pt}{14.4pt}\selectfont\bfseries}
\postauthor{\end{singlespace}\end{center}}

\renewcommand{\maketitlehookc}{%
  \begin{center}
    \begin{singlespace}
      \vspace*{1.49in}

      {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsattitlepage}

      \vspace*{1.34in}

      {\fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase{\thesisplace}}
    \end{singlespace}
  \end{center}
}

\predate{%
  \date{\thesisdate}
  \begin{center}
    \fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase}
\postdate{\end{center}}

\renewcommand{\maketitlehookd}{%
  \newpage
  \thispagestyle{empty}
  \begin{center}
    \vspace*{0.56in}

    {\fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase{\thesislabel}}

    \vspace*{0.36in}

    {\fontsize{12pt}{14.4pt}\selectfont\thethesistitle}

    \vspace*{0.56in}
    {\fontsize{12pt}{14.4pt}\selectfont\theauthorsatacceptancepage}

    \vspace*{2.76in}
    {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsatacceptancepage}
  \end{center}
}

\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{\oldmaketitle\setcounter{page}{3}}
%%
%% End of Format of the Title and Acceptance Pages
%% ============================================================
