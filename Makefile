DOCTYPE = DMTN
DOCNUMBER = 085
DOCNAME = $(DOCTYPE)-$(DOCNUMBER)

GITVERSION := $(shell git log -1 --date=short --pretty=%h)
GITDATE := $(shell git log -1 --date=short --pretty=%ad)
GITSTATUS := $(shell git status --porcelain)
ifneq "$(GITSTATUS)" ""
	GITDIRTY = -dirty
endif

export TEXMFHOME = lsst-texmf/texmf

$(DOCNAME).pdf: $(DOCNAME).tex glossary.tex meta.tex
	xelatex $(DOCNAME)
	makeglossaries $(DOCNAME)
	bibtex $(DOCNAME)
	xelatex $(DOCNAME)
	makeglossaries $(DOCNAME)
	bibtex $(DOCNAME)
	xelatex $(DOCNAME)
	xelatex $(DOCNAME)

.PHONY: clean
clean:
	rm -f DMTN-085.aux
	rm -f DMTN-085.bbl
	rm -f DMTN-085.blg
	rm -f DMTN-085.glg
	rm -f DMTN-085.glo
	rm -f DMTN-085.gls
	rm -f DMTN-085.ist
	rm -f DMTN-085.log
	rm -f DMTN-085.out
	rm -f DMTN-085.pdf
	rm -f DMTN-085.rec
	rm -f DMTN-085.toc
	rm -f meta.tex

.FORCE:

meta.tex: Makefile .FORCE
	rm -f $@
	touch $@
	echo '% GENERATED FILE -- edit this in the Makefile' >>$@
	/bin/echo '\newcommand{\lsstDocType}{$(DOCTYPE)}' >>$@
	/bin/echo '\newcommand{\lsstDocNum}{$(DOCNUMBER)}' >>$@
	/bin/echo '\newcommand{\vcsRevision}{$(GITVERSION)$(GITDIRTY)}' >>$@
	/bin/echo '\newcommand{\vcsDate}{$(GITDATE)}' >>$@
