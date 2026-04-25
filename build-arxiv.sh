#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
QMD_FILE="${ROOT_DIR}/cmp-position-paper.qmd"
TEX_FILE="${ROOT_DIR}/cmp-position-paper.tex"
PDF_FILE="${ROOT_DIR}/cmp-position-paper.pdf"
PACKAGE_DIR="${ROOT_DIR}/arxiv-package"
ZIP_FILE="${ROOT_DIR}/cmp-arxiv-source.zip"
MAIN_TEX="${PACKAGE_DIR}/main.tex"

echo "==> Rendering PDF and TeX with Quarto"
quarto render "${QMD_FILE}" --to pdf

if [ ! -f "${TEX_FILE}" ]; then
  echo "ERROR: ${TEX_FILE} was not generated."
  echo "Make sure cmp-position-paper.qmd has pdf.keep-tex: true."
  exit 1
fi

if [ ! -f "${PDF_FILE}" ]; then
  echo "ERROR: ${PDF_FILE} was not generated."
  exit 1
fi

echo "==> Staging arXiv source"
rm -rf "${PACKAGE_DIR}"
mkdir -p "${PACKAGE_DIR}"
cp "${TEX_FILE}" "${MAIN_TEX}"

echo "==> Checking arXiv source"
if grep -Eq '\\(bibliography|addbibresource|printbibliography)' "${MAIN_TEX}"; then
  echo "ERROR: main.tex still contains bibliography commands."
  echo "arXiv generally expects resolved references, not a raw BibTeX run."
  exit 1
fi

if grep -Eq '\\includegraphics' "${MAIN_TEX}"; then
  echo "WARNING: main.tex references graphics. If figures are added later, include them in ${PACKAGE_DIR}."
fi

if LC_ALL=C grep -n '[^ -~]' "${MAIN_TEX}" >/dev/null 2>&1; then
  echo "ERROR: main.tex contains non-ASCII characters that may break pdflatex/arXiv."
  LC_ALL=C grep -n '[^ -~]' "${MAIN_TEX}" || true
  exit 1
fi

echo "==> Creating zip"
rm -f "${ZIP_FILE}"
(
  cd "${PACKAGE_DIR}"
  zip -q -X "${ZIP_FILE}" main.tex
)

echo "==> Done"
echo "PDF: ${PDF_FILE}"
echo "arXiv source: ${ZIP_FILE}"
unzip -l "${ZIP_FILE}"
