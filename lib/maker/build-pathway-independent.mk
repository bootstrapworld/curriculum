# created 2023-01-15
# last modified 2023-01-18

# asc-file = $(dir $1).cached/.$(patsubst %.adoc,%.asc,$(notdir $1))

pathway-independent-adoc-files := $(wildcard $(TOPDIR)/distribution/$(NATLANG)/textbooks/**.adoc)

pathway-independent-asc-files := $(foreach adocf,$(pathway-independent-adoc-files),$(call asc-file,$(adocf)))

# debug-build-pathway-independent:
# 	@echo pwadocf is $(pathway-independent-adoc-files)
# 	@echo pwascf is $(pathway-independent-asc-files)

build-pathway-independent: $(pathway-independent-asc-files)

define make-build-pathway-independent-rule
$(call asc-file,$1): $1
	@# @echo build-pathway-independent: creating $$@ from $$<
	@TOPDIR=$(TOPDIR) NATLANG=$(NATLANG)  \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_PWYINDEP_INPUT=$(ADOC_POSTPROC_PWYINDEP_INPUT) \
	       $(MAKE_DIR)/do-pathway-independent-adoc $$<

endef

$(eval $(foreach adocf,$(pathway-independent-adoc-files),$(call make-build-pathway-independent-rule,$(adocf))))
