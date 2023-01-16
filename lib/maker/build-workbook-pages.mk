# created 2023-01-16
# last modified 2023-01-16

# asc-file = $(dir $1).cached/.$(patsubst %.adoc,%.asc,$(notdir $1))

relevant-lessons := $(foreach \
	lesson-name,$(shell \
	cat $(RELEVANT_LESSONS_INPUT)),distribution/$(NATLANG)/lessons/$(lesson-name))

relevant-adoc-files := $(foreach \
	lesson,$(relevant-lessons),$(wildcard $(lesson)/**/*.adoc))

relevant-asc-files := $(foreach \
	adocf,$(relevant-adoc-files),$(call asc-file,$(adocf)))

# debug-build-workbook-pages:
# 	@echo rl is $(relevant-lessons)
# 	@echo radocf is $(relevant-adoc-files)
# 	@echo rascf is $(relevant-asc-files)

build-workbook-pages: $(relevant-asc-files)

define make-build-workbook-page-rule
$(call asc-file,$1): $1
	@# @echo build-workbook-pages: creating $$@ from $$<
	@TOPDIR=$(TOPDIR) NATLANG=$(NATLANG) CALLEDFROM=build-workbook-pages \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_WORKBOOKPAGE_INPUT=$(ADOC_POSTPROC_WORKBOOKPAGE_INPUT) \
	       $(MAKE_DIR)/do-adoc $$<

endef

$(eval $(foreach adocf,$(relevant-adoc-files),$(call make-build-workbook-page-rule,$(adocf))))
