TEXFILE=paper.tex
TARGET=paper
TEXSRCS=figures paper.tex paper.bib 
TEXFILES=$(wildcard *.tex)
BIBFILES=paper.bib
FIGFILES=$(wildcard figures/*.pdf)

#all: ${TARGET}.pdf
all: 
	# todo build refs and bibtex
	pdflatex paper.tex


${TARGET}.pdf: ${TEXFILES} ${BIBFILES} ${FIGFILES} ${TARGET}.bbl
	( \
	pdflatex $(TARGET).tex; \
	while grep -q "Rerun to get cross-references right." $(<:.tex=.log); \
	do \
		pdflatex $(TARGET).tex; \
	done \
	)

${TARGET}.bbl: ${TARGET}.bib
	pdflatex ${TARGET}.tex
	bibtex ${TARGET}
	pdflatex ${TARGET}.tex
	pdflatex ${TARGET}.tex

clean:
	rm -f \
	$(TEXFILE:.tex=.aux) \
	$(TEXFILE:.tex=.log) \
	$(TEXFILE:.tex=.out) \
	$(TEXFILE:.tex=.dvi) \
	$(TEXFILE:.tex=.pdf) \
	$(TEXFILE:.tex=.thm) \
	$(TEXFILE:.tex=.bbl) \
	$(TEXFILE:.tex=.blg) \
	$(TEXFILE:.tex=.ps)
