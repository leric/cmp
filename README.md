# Context Minimization as a Lens for Software Design

This repository contains the source for the position paper **"Context Minimization as a Lens for Software Design"** by Leric Zhang.

The paper proposes the **Context Minimization Principle (CMP)**: a software design is better, all else equal, when it reduces the context a human developer or AI coding agent must load to answer a concrete engineering query reliably, without obscuring essential domain complexity.

## Repository Contents

- `cmp-position-paper.qmd` - main Quarto source for the paper.
- `references.bib` - bibliography entries.
- `draft.md` - working draft text.
- `build-arxiv.sh` - helper script that renders the PDF and prepares an arXiv source package.

Generated files such as PDF, HTML, LaTeX, and arXiv package outputs are ignored by `.gitignore`.

## Building

Install [Quarto](https://quarto.org/) and a LaTeX distribution with `pdflatex`, then run:

```sh
quarto render cmp-position-paper.qmd
```

To build the PDF and package the arXiv source:

```sh
./build-arxiv.sh
```

The script renders `cmp-position-paper.pdf`, keeps the generated TeX source, checks the arXiv package, and creates `cmp-arxiv-source.zip`.

## Citation

If you cite this work before a formal publication record is available, use:

```bibtex
@misc{zhang2026contextminimization,
  title = {Context Minimization as a Lens for Software Design},
  author = {Zhang, Leric},
  year = {2026},
  note = {Position paper}
}
```

## License

The paper text, bibliography, and repository materials are licensed under the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/). See `LICENSE` for details.
