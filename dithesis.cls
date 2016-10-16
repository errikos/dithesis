%%
%% dithesis.cls version 0.3
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
%% version 0.3:
%% - Brought up-to-date with 2016 requirements.
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
\ProvidesClass{dithesis}[2016/10/01 v0.3 DIT.UoA Undergraduate Thesis LaTeX
  document class]

\LoadClass[a4paper,titlepage,oneside,12pt]{article}[2005/09/16]
\newif\ifenglish

\DeclareOption{english}{\englishtrue}
\DeclareOption{greek}{\englishfalse}
\ProcessOptions\relax
%% ============================================================

%%
%% User Interface Commands
%%
% \thesistitle{text}: set the title of thesis to text
% \thethesistitle:    access the title of thesis later in the document
% \DeclareRobustCommand{\thesistitle}[1]{\title{#1}\let\thethesistitle\thetitle}
\newcommand{\thesistitleEN}{Thesis Title}
\newcommand{\thesistitleGR}{Τίτλος Πτυχιακής}
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
\newcommand{\universityEN}{National and Kapodistrian University of Athens}
\newcommand{\universityGR}{Εθνικό και Καποδιστριακό Πανεπιστήμιο Αθηνών}
\newcommand{\schoolEN}{School of Science}
\newcommand{\schoolGR}{Σχολή Θετικών Επιστημών}
\newcommand{\departmentEN}{Department of Informatics and Telecommunications}
\newcommand{\departmentGR}{Τμήμα Πληροφορικής και Τηλεπικοινωνιών}
\newcommand{\thesislabelEN}{BSc Thesis}
\newcommand{\thesislabelGR}{Πτυχιακή Εργασία}
\newcommand{\supervisorlabelEN}{Supervisor}
\newcommand{\supervisorlabelGR}{Επιβλέπων}
\newcommand{\idlabelEN}{S.N.}
\newcommand{\idlabelGR}{Α.Μ.}
\newcommand{\thesisplaceEN}{Athens}
\newcommand{\thesisplaceGR}{Αθήνα}
\newcommand{\thesisdateEN}{September 2011}
\newcommand{\thesisdateGR}{Σεπτέμβρης 2011}

% \thesisauthor{Name}{ID}: set the author of the thesis; their name is Name and
%                          their departmental identification number is ID.
% for multiple authors, just use the \thesisauthor command multiple times.
% relative ordering is preserved.
% \thethesisauthor:        access the author(s) of the thesis, as a list of
%                          comma-separated values.
\makeatletter % ENGLISH
\newcommand{\thesisauthorEN}[2]{%
  \ifthenelse{\isundefined{\theauthorsattitlepageEN}}{%
    \def\theauthorsattitlepageEN{#1}
  }%
  {%
    \g@addto@macro\theauthorsattitlepageEN{\\#1}
  }
  \ifthenelse{\isundefined{\theauthorsatacceptancepageEN}}{%
    \def\theauthorsatacceptancepageEN{\textbf{#1}\\\textbf{\idlabelEN:} #2}
  }%
  {%
    \g@addto@macro\theauthorsatacceptancepageEN{%
      \\\textbf{#1}\\\textbf{\idlabelEN:} #2}
  }
  \ifthenelse{\isundefined{\theauthorsatfootersEN}}{%
    \def\theauthorsatfootersEN{#1}
  }%
  {%
    \g@addto@macro\theauthorsatfootersEN{, #1}
  }
}
\makeatother
\newcommand{\thethesisauthorEN}{\theauthorsatfootersEN}

\makeatletter % GREEK
\newcommand{\thesisauthorGR}[2]{%
  \ifthenelse{\isundefined{\theauthorsattitlepageGR}}{%
    \def\theauthorsattitlepageGR{#1}
  }%
  {%
    \g@addto@macro\theauthorsattitlepageGR{\\#1}
  }
  \ifthenelse{\isundefined{\theauthorsatacceptancepageGR}}{%
    \def\theauthorsatacceptancepageGR{\textbf{#1}\\\textbf{\idlabelGR:} #2}
  }%
  {%
    \g@addto@macro\theauthorsatacceptancepageGR{%
      \\\textbf{#1}\\\textbf{\idlabelGR:} #2}
  }
  \ifthenelse{\isundefined{\theauthorsatfootersGR}}{%
    \def\theauthorsatfootersGR{#1}
  }%
  {%
    \g@addto@macro\theauthorsatfootersGR{, #1}
  }
}
\makeatother
\newcommand{\thethesisauthorGR}{\theauthorsatfootersGR}


% \supervisor{Name}{Profession}: set the supervisor of the thesis; their name is
%                                Name and their profession is indicated by
%                                Profession (e.g. Professor, PhD Student, etc).
% for multiple supervisors, just use the \supervisor command multiple times.
% relative ordering is preserved.
\makeatletter % ENGLISH
\newcommand{\supervisorEN}[2]{%
  \ifthenelse{\isundefined{\thesupervisorslistEN}}{%
    \def\thesupervisorslistEN{\textbf{#1,} #2}
  }%
  {%
    \g@addto@macro\thesupervisorslistEN{\\&\textbf{#1,} #2}
  }
}
\makeatother

\makeatletter % GREEK
\newcommand{\supervisorGR}[2]{%
  \ifthenelse{\isundefined{\thesupervisorslistGR}}{%
    \def\thesupervisorslistGR{\textbf{#1,} #2}
  }%
  {%
    \g@addto@macro\thesupervisorslistGR{\\&\textbf{#1,} #2}
  }
}
\makeatother

% ENGLISH
\newcommand{\thesupervisorsattitlepageEN}{%
  \begin{table*}[!h]
    \begin{tabular}{l l}
      \textbf{\supervisorlabelEN:} & \thesupervisorslistEN \\
    \end{tabular}
  \end{table*}
}

% GREEK
\newcommand{\thesupervisorsattitlepageGR}{%
  \begin{table*}[!h]
    \begin{tabular}{l l}
      \textbf{\supervisorlabelGR:} & \thesupervisorslistGR \\
    \end{tabular}
  \end{table*}
}

% ENGLISH
\newcommand{\thesupervisorsatacceptancepageEN}{%
  \begin{table*}[!h]
    \begin{tabular}{l l}
      \textbf{\MakeUppercase{\supervisorlabelEN:}} & \thesupervisorslistEN \\
    \end{tabular}
  \end{table*}
}

% GREEK
\newcommand{\thesupervisorsatacceptancepageGR}{%
  \begin{table*}[!h]
    \begin{tabular}{l l}
      \textbf{\MakeUppercase{\supervisorlabelGR:}} & \thesupervisorslistGR \\
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

\newenvironment{thesisacknowledgments}[1][Acknowledgments]
               { \newpage
                 \pagestyle{empty}
                 \section*{#1}
                 \vspace*{0.3in}}
               {\clearpage\pagestyle{fancy}}

\newenvironment{thesisprologue}[1][Preface]
               { \thesissection*{#1}
                 \pagestyle{empty}}
               {\clearpage\pagestyle{fancy}}

\newenvironment{thesisterminology}[1][Table of Terminology]
               { \thesissection*{#1}}
               {}

\newenvironment{thesisabbreviations}[1][Abbreviations -- Acronyms]
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
\ifenglish
\fancyhead[L]{\fontsize{8pt}{9.6pt}\selectfont\thesistitleEN}
\else
\fancyhead[L]{\fontsize{8pt}{9.6pt}\selectfont\thesistitleGR}
\fi
\fancyfoot[R]{\fontsize{10pt}{12pt}\selectfont\thepage}
\fancyfoot[C]{}
\ifenglish
\fancyfoot[L]{\fontsize{8pt}{9.6pt}\selectfont\theauthorsatfootersEN}
\else
\fancyfoot[L]{\fontsize{8pt}{9.6pt}\selectfont\theauthorsatfootersGR}
\fi
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

\let\oldmaketitle\maketitle
\ifenglish
\renewcommand{\maketitle}{\oldmaketitle\setcounter{page}{5}}
\else
\renewcommand{\maketitle}{\oldmaketitle\setcounter{page}{3}}
\fi

%%
%% End of Format of the Title and Acceptance Pages
%% ============================================================
\newcommand{\maketitleEN}{%
  \setlength{\droptitle}{-112pt}
  \renewcommand{\maketitlehooka}{%
    \begin{center}
      \begin{singlespace}
        \includegraphics[height=2.35cm]{athena-black.pdf}
        \vspace*{0.28in}

        {\fontsize{14pt}{16.8pt}\selectfont\bfseries
          \MakeUppercase{\universityEN}}

        \vspace*{0.12in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\schoolEN}} \\
        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\departmentEN}}

        \vspace*{0.84in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\thesislabelEN}}

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
    \vspace*{0.48in}
  }

  \preauthor{%
    \author{\theauthorsattitlepageEN}
    \begin{center}
      \begin{singlespace}
        \fontsize{12pt}{14.4pt}\selectfont\bfseries}
  \postauthor{\end{singlespace}\end{center}}

  \renewcommand{\maketitlehookc}{%
    \begin{center}
      \begin{singlespace}
        \vspace*{1.48in}

        {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsattitlepageEN}

        \vspace*{1.32in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase{\thesisplaceEN}}
      \end{singlespace}
    \end{center}
  }

  \predate{%
    \date{\thesisdateEN}
    \begin{center}
      \fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase}
  \postdate{\end{center}}

  \maketitle
}

\newcommand{\maketitleGR}{%
  \setlength{\droptitle}{-112pt}
  \renewcommand{\maketitlehooka}{%
    \begin{center}
      \begin{singlespace}
        \includegraphics[height=2.35cm]{athena-black.pdf}
        \vspace*{0.28in}

        {\fontsize{14pt}{16.8pt}\selectfont\bfseries
          \MakeUppercase{\universityGR}}

        \vspace*{0.12in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\schoolGR}} \\
        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\departmentGR}}

        \vspace*{0.84in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\thesislabelGR}}

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
    \vspace*{0.48in}
  }

  \preauthor{%
    \author{\theauthorsattitlepageGR}
    \begin{center}
      \begin{singlespace}
        \fontsize{12pt}{14.4pt}\selectfont\bfseries}
  \postauthor{\end{singlespace}\end{center}}

  \renewcommand{\maketitlehookc}{%
    \begin{center}
      \begin{singlespace}
        \vspace*{1.48in}

        {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsattitlepageGR}

        \vspace*{1.32in}

        {\fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase{\thesisplaceGR}}
      \end{singlespace}
    \end{center}
  }

  \predate{%
    \date{\thesisdateGR}
    \begin{center}
      \fontsize{12pt}{14.4pt}\selectfont\bfseries\MakeUppercase}
  \postdate{\end{center}}

  \maketitle
}

\newcommand{\makeacceptanceEN}{%
  \setlength{\droptitle}{-168pt}

  \renewcommand{\maketitlehooka}{%
    \begin{center}
      \begin{singlespace}
        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\thesislabelEN}}
        \vspace*{0.31in}
      \end{singlespace}
    \end{center}
  }

  \renewcommand{\maketitlehookb}{%
    \vspace*{0.60in}
  }

  \preauthor{}
  \author{}
  \postauthor{}

  \renewcommand{\maketitlehookc}{%
    \begin{center}
      {\fontsize{12pt}{14.4pt}\selectfont\theauthorsatacceptancepageEN}
    \end{center}
  }

  \predate{}
  \date{}
  \postdate{}

  \renewcommand{\maketitlehookd}{%
    % \begin{center}
      \vspace*{2.76in}
      {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsatacceptancepageEN}
    % \end{center}
  }

  \pretitle{%
    \begin{center}
      \begin{singlespace}
        \fontsize{16pt}{19.2pt}}
  \posttitle{\end{singlespace}\end{center}}

  \maketitle
}

\newcommand{\makeacceptanceGR}{%
  \setlength{\droptitle}{-168pt}

  \renewcommand{\maketitlehooka}{%
    \begin{center}
      \begin{singlespace}
        {\fontsize{12pt}{14.4pt}\selectfont\bfseries
          \MakeUppercase{\thesislabelGR}}
        \vspace*{0.31in}
      \end{singlespace}
    \end{center}
  }

  \renewcommand{\maketitlehookb}{%
    \vspace*{0.60in}
  }

  \preauthor{}
  \author{}
  \postauthor{}

  \renewcommand{\maketitlehookc}{%
    \begin{center}
      {\fontsize{12pt}{14.4pt}\selectfont\theauthorsatacceptancepageGR}
    \end{center}
  }

  \predate{}
  \date{}
  \postdate{}

  \renewcommand{\maketitlehookd}{%
    % \begin{center}
      \vspace*{2.76in}
      {\fontsize{12pt}{14.4pt}\selectfont\thesupervisorsatacceptancepageGR}
    % \end{center}
  }

  \pretitle{%
    \begin{center}
      \begin{singlespace}
        \fontsize{16pt}{19.2pt}}
  \posttitle{\end{singlespace}\end{center}}

  \maketitle
}

\newcommand{\makethesistitle}{%
  \ifenglish
  \title{\thesistitleEN}
  \maketitleEN
  \fi
  \title{\thesistitleGR}
  \maketitleGR
  \ifenglish
  \title{\thesistitleEN}
  \makeacceptanceEN
  \fi
  \title{\thesistitleGR}
  \makeacceptanceGR
}
