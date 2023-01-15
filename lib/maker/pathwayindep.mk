# created 2023-01-15
# last modified 2023-01-15

adoc-files = $(wildcard $(TOPDIR)/distribution/$(NATLANG)/textbooks/**.adoc)

asc-file = $(dir $1).cached/$(patsubst %.adoc,%.asc,$(notdir $1))

asc-files = $(foreach adocf,$(adoc-files),$(call asc-file,$(adocf)))

pathwayindep: $(asc-files)

define make-doadoc-rule
$(call asc-file,$1): $1
	echo creating $$@ from $$<
	TOPDIR=$(TOPDIR) NATLANG=$(NATLANG) CALLEDFROM=pathwayindep \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_PWYINDEP_INPUT=$(ADOC_POSTPROC_PWYINDEP_INPUT) \
	       $(MAKE_DIR)/doadoc $$< 

endef

$(eval $(foreach adocf,$(adoc-files),$(call make-doadoc-rule,$(adocf))))
