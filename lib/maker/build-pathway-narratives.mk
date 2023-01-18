# created 2023-01-17
# last modified 2023-01-17

narrative-adoc-files := $(wildcard distribution/$(NATLANG)/courses/*/index.adoc)

narrative-asc-files := $(foreach \
	adocf,$(narrative-adoc-files),$(call asc-file,$(adocf)))

build-pathway-narratives: $(narrative-asc-files)

define make-build-narrative-rule
$(call asc-file,$1): $1
	@# @echo build-narratives: creating $$@ from $$<
	@TOPDIR=$(TOPDIR) NATLANG=$(NATLANG) CALLEDFROM=build-pathway-narratives \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_NARRATIVE_INPUT=$(ADOC_POSTPROC_NARRATIVE_INPUT) \
	       $(MAKE_DIR)/do-adoc $$<

endef

$(eval $(foreach adocf,$(narrative-adoc-files),$(call make-build-narrative-rule,$(adocf))))
