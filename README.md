# dndnote

`dndnote` is a LaTeX class for short documents styled like handwritten notes on
parchment. By default it renders a generated sepia paper background with red ink
and a rough handwritten fallback font available in TeX Live.

## Install location

This package lives in:

`~/.local/share/texmf/tex/latex/dndnote`

Because that path is inside `TEXMFHOME`, TeX should find `dndnote.cls` anywhere
on the system with:

```tex
\documentclass{dndnote}
```

## Files

- `dndnote.cls` - the class file
- `example.tex` - a minimal example document

## Usage

Compile the example from any directory with:

```sh
pdflatex example.tex
```

If you use `latexmk`, this repository includes a local `.latexmkrc` that keeps
generated files out of the source directory:

```sh
latexmk -pdf example.tex
```

This writes the final PDF to `build/example.pdf` and auxiliary files to
`build/aux/`.

If your document uses `\dndnotefont{...}` with a local font file, use:

```sh
latexmk -xelatex example.tex
```

Or use the class in another document:

```tex
\documentclass{dndnote}
\title{Session Notes}
\author{Your Name}
\date{\today}

\begin{document}
\maketitle
Your note text goes here.
\end{document}
```

To use a local background image and a local font file in your document preamble:

```tex
\documentclass{dndnote}
\dndnotebackground{/path/to/background.jpg}
\dndnotefont{/path/to/handwriting-font.ttf}
```

Custom font files require `xelatex` or `lualatex`. Background images work with
`pdflatex`, `xelatex`, or `lualatex`.

If you want to use downloaded web assets, point these commands at the local
files after downloading them.

To add a right-aligned signature line in italic:

```tex
\dndnotesignature{Elminster}
```

Class options:

```tex
\documentclass[plain]{dndnote}      % no generated background
\documentclass[parchment]{dndnote}  % generated parchment background
\documentclass[ruled]{dndnote}      % generated ruled notebook background
\documentclass[24pt,leading=0.8]{dndnote} % tighter line spacing
```
