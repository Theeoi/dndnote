# LaTeX dndnote

`dndnote` is a small LaTeX class for one-page handwritten-style notes.

It defaults to:

- a parchment background image
- the `Rock Salt` handwriting font

The package assets live in [assets](./assets), and the class still lets you
override the default background and font from your document.

## Install

This project is intended to live inside your `TEXMFHOME`, for example:

```sh
~/.local/share/texmf/tex/latex/dndnote
```

Once it is there, LaTeX should find the class with:

```tex
\documentclass{dndnote}
```

## Compile

The default handwriting font uses `fontspec`, so the recommended engines are `xelatex` or `lualatex`.

`pdflatex` will still compile, but it will fall back to the default LaTeX font.

## Example

The included [example.tex](./example.tex) renders as below with xelatex:

![Rendered example](./assets/example-preview.png)

## Class Options

You can pass these options in `\documentclass[...]`:

- `<n>pt` sets the document font size, for example `20pt` or `24pt`
- `margin=<dimension>` sets the page margin, default `22mm`

Examples:

```tex
\documentclass{dndnote}
\documentclass[20pt]{dndnote}
\documentclass[24pt,margin=18mm]{dndnote}
```

## Commands

Set a custom background image:

```tex
\dndnotebackground{/path/to/background.jpg}
```

Set a custom font:

```tex
\dndnotefont{/path/to/font.ttf}
```

You can also use an installed font family name:

```tex
\dndnotefont{Rock Salt}
```

Add a greeting with extra space before the following text:

```tex
\dndnotegreeting{Dear friend,}
```

Add a right-aligned italic signature:

```tex
\dndnotesignature{- Elminster -}
```

