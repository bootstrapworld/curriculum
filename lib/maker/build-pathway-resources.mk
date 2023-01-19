# created 2023-01-17
# last modified 2023-01-18

resource-adoc-files := $(wildcard distribution/$(NATLANG)/courses/*/*/**/*.adoc)

resource-asc-files := $(foreach \
	adocf,$(resource-adoc-files),$(call asc-file,$(adocf)))

# build-pathway-resources:
# 	@echo radocf is $(resource-adoc-files)
# 	@echo rascf is $(resource-asc-files)

build-pathway-resources: $(resource-asc-files)

define make-build-resource-rule
$(call asc-file,$1): $1
	@# @echo build-resources: creating $$@ from $$<
	@TOPDIR=$(TOPDIR) NATLANG=$(NATLANG)  \
	       ADOCABLES_INPUT=$(ADOCABLES_INPUT) \
	       ADOC_INPUT=$(ADOC_INPUT) \
	       ADOC_POSTPROC_RESOURCES_INPUT=$(ADOC_POSTPROC_RESOURCES_INPUT) \
	       $(MAKE_DIR)/do-pathway-resource-adoc $$<

endef

$(eval $(foreach adocf,$(resource-adoc-files),$(call make-build-resource-rule,$(adocf))))
