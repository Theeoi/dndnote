\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dndnote}[2025/02/14 Minimal note class]

\newcommand{\dndnotefontsize}{24pt}
\newdimen\dndnotebaselineskip

\ExplSyntaxOn
\cs_new_protected:Npn \dndnote_process_option:n #1
  {
    \regex_match:nnTF { \A \d+pt \Z } {#1}
      { \renewcommand{\dndnotefontsize}{#1} }
      { \PassOptionsToClass{#1}{article} }
  }
\cs_new_protected:Npn \dndnote_process_current_option:
  {
    \exp_args:NV \dndnote_process_option:n \CurrentOption
  }
\cs_new_protected:Npn \dndnoteprocesscurrentoption
  {
    \dndnote_process_current_option:
  }
\ExplSyntaxOff

\DeclareOption*{\dndnoteprocesscurrentoption}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{iftex}
\RequirePackage[margin=20mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{eso-pic}

\ifPDFTeX\else
  \RequirePackage{fontspec}
\fi

\newcommand{\dndnoteempty}{}
\let\dndnotebackgroundfile\dndnoteempty
\let\dndnotefontfile\dndnoteempty

\newcommand{\dndnotebackground}[1]{%
  \gdef\dndnotebackgroundfile{#1}%
}

\newcommand{\dndnotefont}[1]{%
  \gdef\dndnotefontfile{#1}%
}

\newcommand{\dndnotesignature}[1]{%
  \par
  \addvspace{\baselineskip}%
  {%
    \raggedleft
    \itshape
    #1\par
  }%
}

\makeatletter
\newcommand{\dndnotesetmainfont}[1]{%
  \filename@parse{#1}%
  \ifx\filename@area\@empty
    \setmainfont[AutoFakeSlant]{#1}%
  \else
    \ifx\filename@ext\@empty
      \setmainfont[Path={\filename@area},AutoFakeSlant]{\filename@base}%
    \else
      \setmainfont[Path={\filename@area},Extension={.\filename@ext},AutoFakeSlant]{\filename@base}%
    \fi
  \fi
}
\makeatother

\newcommand{\dndnoteapplybackground}{%
  \ifx\dndnotebackgroundfile\dndnoteempty
  \else
    \IfFileExists{\dndnotebackgroundfile}{%
      \AtPageLowerLeft{%
        \includegraphics[width=\paperwidth,height=\paperheight]{\dndnotebackgroundfile}%
      }%
    }{%
      \ClassWarning{dndnote}{Background file '\dndnotebackgroundfile' not found. Using default page background}%
    }%
  \fi
}

\AtBeginDocument{%
  \dndnotebaselineskip=\dndnotefontsize\relax
  \fontsize{\dndnotefontsize}{\dndnotebaselineskip}\selectfont
  \AddToShipoutPictureBG{\dndnoteapplybackground}%
  \ifx\dndnotefontfile\dndnoteempty
  \else
    \ifPDFTeX
      \ClassWarning{dndnote}{Custom font files require XeLaTeX or LuaLaTeX. Using the default LaTeX font}%
    \else
      \IfFileExists{\dndnotefontfile}{%
        \dndnotesetmainfont{\dndnotefontfile}%
      }{%
        \ClassWarning{dndnote}{Font file '\dndnotefontfile' not found. Using the default LaTeX font}%
      }%
    \fi
  \fi
}
