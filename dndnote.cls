\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dndnote}[2025/02/14 Minimal note class]

\newcommand{\dndnotefontsize}{24pt}
\newcommand{\dndnotemargin}{22mm}
\newdimen\dndnotebaselineskip

\ExplSyntaxOn
\cs_new_protected:Npn \dndnote_set_margin:n #1
  {
    \renewcommand{\dndnotemargin}{#1}
  }
\cs_new_protected:Npn \dndnote_process_option:n #1
  {
    \regex_match:nnTF { \A \d+pt \Z } {#1}
      { \renewcommand{\dndnotefontsize}{#1} }
      {
        \seq_set_split:Nnn \l_tmpa_seq { = } {#1}
        \int_compare:nNnTF { \seq_count:N \l_tmpa_seq } = { 2 }
          {
            \str_if_eq:eeTF { \seq_item:Nn \l_tmpa_seq { 1 } } { margin }
              {
                \tl_set:Ne \l_tmpa_tl { \seq_item:Nn \l_tmpa_seq { 2 } }
                \regex_match:nVTF { \A (?: \d+ | \d+\.\d+ ) (?: pt | mm | cm | in ) \Z } \l_tmpa_tl
                  { \exp_args:NV \dndnote_set_margin:n \l_tmpa_tl }
                  { \PassOptionsToClass{#1}{article} }
              }
              { \PassOptionsToClass{#1}{article} }
          }
          { \PassOptionsToClass{#1}{article} }
      }
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
\RequirePackage[margin=\dndnotemargin]{geometry}
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
