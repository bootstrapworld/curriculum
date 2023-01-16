# created 2023-01-15
# last modified 2023-01-16

export NATLANG ?= en-us

export TOPDIR := $(realpath .)

export PROGDIR := $(TOPDIR)/distribution/.prog-$(NATLANG)

export ADOCABLES_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-adocables.rkt
export ADOC_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-asciidoctor.js
export ADOC_POSTPROC_WORKBOOKPAGE_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-adoc-postproc-workbookpage.txt.kp
export ADOC_POSTPROC_LESSONPLAN_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-adoc-postproc-lessonplan.txt.kp
export ADOC_POSTPROC_PWYINDEP_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-adoc-postproc-pwyindep.txt

export RELEVANT_LESSONS_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-relevant-lessons.txt.kp

export PUPPETEER_INPUT := $(TOPDIR)/distribution/$(NATLANG)/.cached/.do-puppeteer.json

export MAKE_DIR = lib/maker

all:
	@$(MAKE) -I $(MAKE_DIR) -f lib/maker/Makefile.phase1
	@$(MAKE) -I $(MAKE_DIR) -f lib/maker/Makefile.phase2
	@$(MAKE) -I $(MAKE_DIR) -f lib/maker/Makefile.phase3
