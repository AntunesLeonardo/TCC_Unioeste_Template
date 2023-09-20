\LoadClass{book}

\RequirePackage{iftex}
\RequireLuaTeX

% Boolean values for options ==============================

\RequirePackage{etoolbox}

% Boolean for print style option
\providebool{boolPrintStyle}
\setbool{boolPrintStyle}{false}

% Boolean for indentation in ToC
\providebool{boolNoTocIndent}
\setbool{boolNoTocIndent}{false}

% Boolean for author-date refence style
\providebool{boolAuthorYearRef}
\setbool{boolAuthorYearRef}{true}

% Boolean for numeric refence style
\providebool{boolNumericRef}
\setbool{boolNumericRef}{false}

% Class options ===========================================

% Pre-textual elements and chapter heading are printed in front pages (odd number) only
% Deferentiates odd from even pages geometry
\DeclareOption{printstyle}{%
    \setbool{boolPrintStyle}{true}
}

\DeclareOption{notocindent}{%
    \setbool{boolNoTocIndent}{true}
}

\DeclareOption{authoryearref}{%
    \setbool{boolNumericRef}{false}
    \setbool{boolAuthorYearRef}{true}
}

\DeclareOption{numericref}{%
    \setbool{boolNumericRef}{true}
    \setbool{boolAuthorYearRef}{false}
}

% Non specified given options are passed to babel as language settings
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{babel}}

\ProcessOptions\relax

% Language settings =======================================

\RequirePackage{babel}

% Font Definition =========================================

\RequirePackage{luainputenc}
\RequirePackage{fontspec}

\defaultfontfeatures{Ligatures=TeX}
\setmainfont{Times New Roman}
\setmonofont{Courier New}

\renewcommand{\small}{\fontsize{10}{12}\selectfont}
\renewcommand{\normalsize}{\fontsize{12}{14}\selectfont}
\renewcommand{\large}{\fontsize{14}{16}\selectfont}
\renewcommand{\Large}{\fontsize{16}{20}\selectfont}
\renewcommand{\LARGE}{\fontsize{18}{22}\selectfont}

% Spancing ================================================

\newcommand{\simplespacing}{%
    \renewcommand\baselinestretch{1}
    \setlength{\parskip}{0pt}
    \setlength{\parindent}{10mm}
}

\newcommand{\textspacing}{%
    \renewcommand\baselinestretch{1.5}
    \setlength{\parskip}{6pt}
    \setlength{\parindent}{10mm}
}

\textspacing

% Paper ===================================================

\RequirePackage{geometry}

\geometry{%
    a4paper,
    portrait,
    onecolumn,
    top=30mm,
    bottom=20mm,
    headheight=17mm,
    footskip=7.5mm,
}

% \geometry{showframe}

\ifbool{boolPrintStyle}{%
    \geometry{%
        twoside=true,
        inner=30mm,
        outer=20mm,
    }
}{
    \geometry{%
        twoside=false,
        left=30mm,
        right=20mm,
    }
}

% Header / footer =========================================

\RequirePackage{fancyhdr}

\ifbool{boolPrintStyle}{%
    \fancypagestyle{TCC_standard}{%
        \fancyhf{}
        \fancyhead[OR]{\thepage}
        \fancyhead[EL]{\thepage}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
    }
}{
    \fancypagestyle{TCC_standard}{%
        \fancyhf{}
        \fancyhead[R]{\thepage}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
    }
}

\fancypagestyle{TCC_chapter}{%
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

\pagestyle{TCC_standard}

% Chapter / Section styling ===============================

\RequirePackage{titlesec}

% Chapter styling
\titleformat{\chapter}[display]{%
    \LARGE\bfseries\raggedright
}{
    \chaptertitlename\ \thechapter
}{12pt}{}

\titlespacing{\chapter}{0mm}{0pt}{12pt}
\assignpagestyle{\chapter}{TCC_chapter}

% Section styling
\titleformat{\section}[hang]{%
    \Large\bfseries\raggedright
}{
    \thesection
}{1em}{}

\titlespacing{\section}{0mm}{12pt}{12pt}

% Subsection styling
\titleformat{\subsection}[hang]{%
    \large\bfseries\raggedright
}{
    \thesubsection
}{1em}{}

\titlespacing{\subsection}{0mm}{12pt}{12pt}

% Subsubsection styling
\titleformat{\subsubsection}[hang]{%
    \normalsize\bfseries\raggedright
}{}{0em}{}

\titlespacing{\subsubsection}{0mm}{12pt}{12pt}

% Unnumbered section styling
\titleformat{name=\section,numberless}[hang]{%
    \Large\bfseries\centering
}{}{0em}{}

\titlespacing{name=\section,numberless}{0mm}{12pt}{12pt}

% Captions ================================================

\RequirePackage{caption}

\captionsetup{%
    format=plain,
    indention=0mm,
    labelformat=simple,
    labelsep=colon,
    textformat=simple,
    justification=centerlast,
    font=normalsize,
    font+=md,
    font+={stretch=1.0},
}

\captionsetup[figure]{%
    position=bottom,
    skip=6pt
}

\captionsetup[table]{%
    position=top,
    skip=3pt
}

% Subcaptions =============================================

\RequirePackage{subcaption}

\subcaptionsetup{%
    format=plain,
    indention=0mm,
    labelformat=parens,
    labelsep=space,
    textformat=simple,
    justification=centerlast,
    font=small,
    font+=it,
    font+={stretch=1.0},
}

% Quotation ===============================================

\RequirePackage[%
    strict=false,
    autostyle=once,
    threshold=3,
    thresholdtype=lines,
]{csquotes}

\newenvironment*{longblockquote}{%
    \trivlist\leftskip=40mm\simplespacing\small\item
}{%
    \endtrivlist\textspacing\normalsize
}

\SetBlockEnvironment{longblockquote}

% References ==============================================

\ifboolexpr{bool{boolAuthorYearRef} or (not bool{boolNumericRef})}{%
    \RequirePackage[%
        backend=biber,
        autolang=other,
        abbreviate=true,
        style=abnt,
        sorting=nty,
        extrayear,
        bibwarn=false,
    ]{biblatex}
}{%
    \RequirePackage[%
        backend=biber,
        autolang=other,
        abbreviate=true,
        style=abnt-numeric,
        sorting=none,
        citestyle=numeric-comp,
        extrayear,
        bibwarn=false,
    ]{biblatex}
}

% Define bib heading
\defbibheading{thebibintoc}[\bibname]{%
    \section*{#1}%
    \markboth{#1}{#1}
    \addcontentsline{toc}{chapter}{#1}
}

% Sets default bib heading and title (language sensitive)
\DeclarePrintbibliographyDefaults{%
    heading={thebibintoc},
    title={Referências Bibliográficas},
}

% Math equations ==========================================

\RequirePackage[%
    centertags,
    sumlimits,
    nointlimits,
    namelimits,
    reqno
    ]{amsmath}

\RequirePackage{amsfonts}
\RequirePackage{amssymb}

\DeclareMathOperator{\sen}{sen}
\DeclareMathOperator{\senh}{senh}
\DeclareMathOperator{\arcsen}{arcsen}


% Packages for images and float positioning ===============

\RequirePackage{graphicx}
\RequirePackage{float}

% ToC / LoF / LoT =========================================

\RequirePackage{tocloft}

\tocloftpagestyle{empty}

% Table of Contents title
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill\hfill}
\setlength{\cftbeforetoctitleskip}{12pt}
\setlength{\cftaftertoctitleskip}{12pt}

% List of Figures title
\renewcommand{\cftloftitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{12pt}
\setlength{\cftafterloftitleskip}{12pt}

% List of Tables title
\renewcommand{\cftlottitlefont}{\hfill\Large\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{12pt}
\setlength{\cftafterlottitleskip}{12pt}

% Toc: include chapter, section and subsection (not subsubsection)
\setcounter{tocdepth}{2}

\setcounter{lofdepth}{1}
\setcounter{lotdepth}{1}

\renewcommand{\cftdot}{.}
\renewcommand{\cftpnumalign}{r}

% Chapter in toc
\setlength{\cftbeforechapskip}{6pt}
\renewcommand{\cftchapfont}{\normalsize\bfseries}

% Section in toc
\setlength{\cftbeforesecskip}{0pt}
\renewcommand{\cftsecfont}{\normalsize\mdseries}

% Subsection in toc
\setlength{\cftbeforesubsecskip}{0pt}
\renewcommand{\cftsubsecfont}{\normalsize\mdseries}

% Figure in lof
\setlength{\cftbeforefigskip}{0pt}
\renewcommand{\cftfigfont}{\normalsize\mdseries}

% Table in lot
\setlength{\cftbeforetabskip}{0pt}
\renewcommand{\cfttabfont}{\normalsize\mdseries}

\ifbool{boolNoTocIndent}{%
    \cftsetindents{chap}{0em}{3em}
    \cftsetindents{sec}{0em}{3em}
    \cftsetindents{subsec}{0em}{3em}
    \cftsetindents{fig}{0em}{3em}
    \cftsetindents{tab}{0em}{3em}
}{%
    \cftsetindents{chap}{0em}{3em}
    \cftsetindents{sec}{3em}{3em}
    \cftsetindents{subsec}{6em}{3em}
    \cftsetindents{fig}{0em}{3em}
    \cftsetindents{tab}{0em}{3em}
}

% Appendix ================================================

\RequirePackage{appendix}

% Change ToC header (language sensitive)
\renewcommand{\appendixtocname}{Apêndices}

% Defines Annex command names (language sensitive)
\newcommand{\annexname}{Anexo}
\newcommand{\annextocname}{Anexos}

% Defines Annex command
\makeatletter
\newcommand\annex{\par%
    \setcounter{chapter}{0}
    \setcounter{section}{0}
    \gdef \@chapapp{\annexname}
    \gdef\thechapter{\@Alph\c@chapter}
    \renewcommand{\theHchapter}{\annexname.\thechapter}
}
\makeatother

\newcommand{\addannheadtotoc}{%
    \addcontentsline{toc}{chapter}{\annextocname}
}

% Hyperlinks ==============================================

\RequirePackage{hyperref}

\hypersetup{%
    luatex,
    hidelinks,
    linktoc=all,
}

\hypersetup{%
    addtopdfcreator={Template de TCC desenvolvido por Leonardo A. Antunes}
}

% Glossries ===============================================

\RequirePackage[%
    symbols,
    acronyms,
    nomain,
    nopostdot,
    nonumberlist,
    nogroupskip,
    nolangwarn,
    translate=true,
    hyperfirst=true,
    section=section,
    toc=false,
]{glossaries}

% New acronym (text) style considering translations in field 'user1'
\newacronymstyle{acronymslang}%
{%
    \GlsUseAcrEntryDispStyle{long-short}%
}{%
    \GlsUseAcrStyleDefs{short-long}%
    \renewcommand*{\genacrfullformat}[2]{%
        \protect\ifglshasfield{useri}{##1}{
        \textit{\glsentrylong{##1}##2}\space%
        (\glsentryuseri{##1} -- \firstacronymfont{\glsentryshort{##1}})%
        }{
        \glsentrylong{##1}##2\space(\firstacronymfont{\glsentryshort{##1}})%
        }
    }%
    \renewcommand*{\Genacrfullformat}[2]{%
        \protect\ifglshasfield{useri}{##1}{
        \textit{\Glsentrylong{##1}##2}\space%
        (\glsentryuseri{##1} -- \firstacronymfont{\glsentryshort{##1}})%
        }{
        \Glsentrylong{##1}##2\space(\firstacronymfont{\glsentryshort{##1}})%
        }
    }%
    \renewcommand*{\genplacrfullformat}[2]{%
        \protect\ifglshasfield{useri}{##1}{
        \textit{\glsentrylongpl{##1}##2}\space%
        (\glsentryuseripl{##1} -- \firstacronymfont{\glsentryshortpl{##1}})%
        }{
        \glsentrylongpl{##1}##2\space(\firstacronymfont{\glsentryshortpl{##1}})%
        }
    }%
    \renewcommand*{\Genplacrfullformat}[2]{%
        \protect\ifglshasfield{useri}{##1}{
        \textit{\Glsentrylongpl{##1}##2}\space%
        (\glsentryuseripl{##1} -- \firstacronymfont{\glsentryshortpl{##1}})%
        }{
        \Glsentrylongpl{##1}##2\space(\firstacronymfont{\glsentryshortpl{##1}})%
        }
    }%
}
\setacronymstyle{acronymslang}

% New acronym (display) style considering translations in field 'user1' 
\newglossarystyle{acronymslang}
{%
  \setglossarystyle{super}%
  \renewcommand*{\glsgroupskip}{}%
  \renewcommand{\glossentry}[2]{%
    \glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &

    \ifglshasfield{useri}{##1}{
        \textit{\Glossentrydesc{##1}}\space(\glsentryuseri{##1})
    }{
        \Glossentrydesc{##1}
    }\space ##2\tabularnewline
  }%
}

\setlength{\glsdescwidth}{1.1\hsize}
\setglossarystyle{acronymslang}

% Acronyms listed as non-bold-face
\renewcommand*{\glsnamefont}[1]{\textmd{#1}}

% Defines acronyms and symbols section title (language sensitive)
\renewcommand{\acronymname}{Lista de Abreveaturas e Siglas}
\renewcommand{\glssymbolsgroupname}{Lista de Símbolos}

% =========================================================
% Commands and memories
% =========================================================

\RequirePackage{listofitems}
\RequirePackage{pgffor}

\renewcommand{\author}[1]{\renewcommand{\author}{#1}}
\renewcommand{\title}[1]{\renewcommand{\title}{#1}}
\newcommand{\subtitle}[1]{\renewcommand{\subtitle}{#1}}
\newcommand{\trabalho}[1]{\renewcommand{\trabalho}{#1}}
\newcommand{\descricao}[1]{\renewcommand{\descricao}{#1}}
\newcommand{\descricaobanca}[1]{\renewcommand{\descricaobanca}{#1}}
\newcommand{\descricaoresumo}[1]{\renewcommand{\descricaoresumo}{#1}}
\newcommand{\descricaoabstract}[1]{\renewcommand{\descricaoabstract}{#1}}

\newcommand{\titleenglish}[1]{\renewcommand{\titleenglish}{#1}}
\newcommand{\subtitleenglish}[1]{\renewcommand{\subtitleenglish}{#1}}
\newcommand{\trabalhoenglish}[1]{\renewcommand{\trabalhoenglish}{#1}}

% =========================================================
% Pre-text elements
% =========================================================

% Cover command -------------------------------------------

\newcommand{\coverpage}{%
    \simplespacing\thispagestyle{empty}
    % University symbol
    \hfill
    \includegraphics[width=22mm]{Unioeste_Simbolo.pdf}
    \hfill\smallskip
    \begin{center}
        % University information
        \foreach \i in {1,...,\listlen\universidade[]}{
            \MakeUppercase{\textbf{\universidade[\i]}}\break
        }
        % Work type
        \vspace{30mm}\break
        \MakeUppercase{\trabalho}\break
        % Title and subtitle
        \vfill
        \ifdefempty{\subtitle}{%
            \MakeUppercase{\textbf{\title}}\break
        }{%
            \MakeUppercase{\textbf{\title:\space\subtitle}}\break
        }
        % Author
        \vspace{30mm}\break
        \MakeUppercase{\textbf{\author}}\break
        % City and date
        \vspace{30mm}\break
        \MakeUppercase{\textbf{\cidade[1]\space-\space\cidade[2]}}\break
        \MakeUppercase{\textbf{\data[3]}}\break
    \end{center}
    \clearpage{\thispagestyle{empty}\cleardoublepage}
    \setcounter{page}{1}
}

% Title page ----------------------------------------------

\renewcommand{\titlepage}{%
    \simplespacing\thispagestyle{empty}
    \begin{center}
        % Author
        \MakeUppercase{\textbf{\author}}\break
        % Title and subtitle
        \vspace{80mm}\break
        \ifdefempty{\subtitle}{%
            \MakeUppercase{\textbf{\title}}\break
        }{%
            \MakeUppercase{\textbf{\title:\space\subtitle}}\break
        }
    \end{center}
    % Description and advisor
    \vspace{15mm}
    \begin{trivlist}\leftskip=0.5\textwidth
        \simplespacing
        \item \descricao
        \smallskip
        \item \orientador[1,1]:\space\orientador[1,2]\space\orientador[1,3]
    \end{trivlist}
    \begin{center}
        % City and date
        \vfill
        \MakeUppercase{\cidade[1]\space-\space\cidade[2]}\break
        \MakeUppercase{\data[3]}\break
    \end{center}
    \clearpage{\thispagestyle{empty}\cleardoublepage}
}

% Examining board page-------------------------------------

\newcommand{\examiningboard}{%
    \simplespacing\thispagestyle{empty}
    % University symbol
    \hfill
    \includegraphics[width=22mm]{Unioeste_Simbolo.pdf}
    \hfill\break\bigskip
    \begin{flushleft}
        % Title (language sensitive)
        \MakeUppercase{\textbf{Título:}}\space\title\break
        % Author (language sensitive)
        \vspace{3mm}\break
        \MakeUppercase{\textbf{Autor:}}\space\author\break
        % Advisors
        \foreach \i in {1,...,\listlen\orientador[]}{
            \MakeUppercase{\textbf{\orientador[\i,1]:}}\space\orientador[\i,3]\break
        }
    \end{flushleft}
    % Description
    \descricaobanca\break
    \begin{flushleft}
        \foreach \i in {1,...,\listlen\orientador[]}{
            \orientador[\i,1]:\space\orientador[\i,2]\space\textbf{\orientador[\i,3]}\break
            \orientador[\i,4]\break
            \vspace{1mm}\break
        }
        \foreach \i in {1,...,\listlen\banca[]}{
            \banca[\i,1]\space\textbf{\banca[\i,2]}\break
            \banca[\i,3]\break
            \vspace{1mm}\break
        }
    \end{flushleft}
    \vfill
    \begin{center}
        % City and date (language sensitive)
        \cidade[1],\space\data[1]\space{de}\space\data[2]\space{de}\space\data[3]
    \end{center}
    \clearpage{\thispagestyle{empty}\cleardoublepage}
}

% Pre-text enviorments ------------------------------------

% Dedicatoria
\newenvironment{dedicatoria}{%
    \thispagestyle{empty}\null\vfill\flushright\textspacing
}{%
    \endflushright\clearpage{\thispagestyle{empty}\cleardoublepage}
}

% Agradecimentos (language sensitive)
\newenvironment{agradecimentos}{%
    \thispagestyle{empty}\section*{Agradecimentos}\textspacing
}{%
    \clearpage{\thispagestyle{empty}\cleardoublepage}
}

% Epígrafe
\newenvironment{epigrafe}{%
    \thispagestyle{empty}\null\vfill\null\hfill\minipage{0.5\textwidth}\flushright
}{%
    \endflushright\endminipage\clearpage{\thispagestyle{empty}\cleardoublepage}
}

% Resumo
\newenvironment{resumo}{%
    \thispagestyle{empty}\section*{Resumo}\textspacing
}{%
    \clearpage{\thispagestyle{empty}\cleardoublepage}
}

\newenvironment{abstract}{%
    \thispagestyle{empty}\section*{Abstract}\textspacing
}{%
    \clearpage{\thispagestyle{empty}\cleardoublepage}
}

\hfuzz=2.50pt

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TCC_class}[2023/05/23 Work In Progress]