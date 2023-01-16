# created 2023-01-16
# last modified 2023-01-16

lesson-plan-adoc-files := $(foreach \
	lesson,$(relevant-lessons),$(lesson)/index.adoc)

lesson-plan-asc-files := $(foreach \
	adocf,$(lesson-plan-adoc-files),$(call asc-file,$(adocf)))

# build-lesson-plans:
# 	@echo lpadocf is $(lesson-plan-adoc-files)
# 	@echo lpascf is $(lesson-plan-asc-files)

build-lesson-plans: $(lesson-plan-asc-files)

define make-build-lesson-plan-rule
$(call asc-file,$1): $1
	@TOPDIR=$(TOPDIR) NATLANG=$(NATLANG) CALLEDFROM=build-lesson-plans \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_LESSONPLAN_INPUT=$(ADOC_POSTPROC_LESSONPLAN_INPUT) \
	       $(MAKE_DIR)/do-adoc $$<

endef

$(eval $(foreach adocf,$(lesson-plan-adoc-files),$(call make-build-lesson-plan-rule,$(adocf))))
