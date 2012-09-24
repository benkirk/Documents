DOCUMENT    := dissertation
MAIN_SOURCE := dissertation.tex
BIB         := dissertation.bib
PREAM       := preamble_from_makefile_bits.tex
PREAM_STUB  := bin/preamble_from_makefile_bits.stub
LATEX       := pdflatex
EPSTOPDF    := epstopdf

VPATH := .:$(HOME)/work/repos/bibliography

CHAPTERS   := $(wildcard chapters/*.tex)
APPENDICES := $(wildcard appendix/*.tex)
STYLES     := $(wildcard *.sty)
EPSFIGS    := $(wildcard figures/*/*.eps)
PDFFIGS    := $(wildcard figures/*/*.pdf)
FIGURES    := $(PDFFIGS)

%.pdf: %.eps
	$(EPSTOPDF) $<


all:: pdffigs $(DOCUMENT) 

$(DOCUMENT): $(MAIN_SOURCE) $(CHAPTERS) $(APPENDICES) $(STYLES) $(BIB) $(FIGURES) Makefile
	$(LATEX) $<

.PHONY: all echo clean neat clobber pdffigs $(DOCUMENT)

pdffigs: $(FIGURES)

echo:
	@echo $(DOCUMENT) $(PREAM) $(MAIN_SOURCE)

clobber:: clean
	rm -f *~ *.dvi *.dvi.gz;                                       \
	if [ -f $(DOCUMENT).pdf ]; then                                \
	  rm -i $(DOCUMENT).pdf;                                       \
        fi

clean:: neat
	$(RM) ./chapters/*~ ./chapters/*.aux                             \
	$(RM) ./appendix/*~ ./appendix/*.aux                             \
	$(RM) *.toc *.aux *.log *.cp *.fn *.tp *.vr *.pg *.ky;           \
	$(RM) *.bbl *.blg *.lof *.lot *.loa *.brf;                       \
	$(RM) *.cps *.fns *.kys *.tps *.vrs *.pgs *.kys                  \
	$(RM) *.auxO *.bblO *.cpO;                                       \
	$(RM) *.fnO *.tpO *.vrO *.pgO *.kyO  _region_.tex .date;	 \
	$(RM) *.idx *.ilg *.ind *.gz~;					 \
	$(RM) *.toc.gz *.aux.gz *.log.gz *.cp.gz *.fn.gz;                \
	$(RM) *.tp.gz *.vr.gz *.pg.gz;                                   \
	$(RM) *.ky.gz *.bbl.gz *.blg.gz *.lot.gz;	                 \
	$(RM) *.cps.gz *.fns.gz *.kys.gz *.tps.gz;                       \
	$(RM) *.vrs.gz *.pgs.gz *.kys.gz;                                \
	$(RM) *.auxO.gz *.bblO.gz *.cpO.gz;				 \
	$(RM) *.fnO.gz *.tpO.gz *.vrO.gz *.pgO.gz *.kyO.gz *.lof.gz;	 \
	$(RM) _region_.tex.gz .date.gz;					 \
	$(RM) *.idx.gz *.ilg.gz *.ind.gz;	                         \
	$(RM) *.tex.bak *.tex.bak.gz;					 \
	$(RM) *.cb *.cb.gz                                               \
	$(RM) *.out

neat:: ;








