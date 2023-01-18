# created 2023-01-16
# last modified 2023-01-17

the-pathways := $(wildcard pathways/*)


the-courses := $(patsubst \
	%,distribution/$(NATLANG)/courses/%/.,$(notdir $(the-pathways)))

# the-courses := $(foreach \
# 	pathway,$(the-pathways),distribution/$(NATLANG)/courses/$(notdir $(pathway))/.)

# copy-pathways:
# 	@echo tp is $(the-pathways)
# 	@echo tc is $(the-courses)

copy-pathways: $(the-courses)

define make-copy-pathway-rule
distribution/$(NATLANG)/courses/$(notdir $1)/.: $1
	@# echo making $$@ from $$<
	@mkdir -p $$@
	@touch $$@
	@if test ! -f $$</langs/$(NATLANG)/index.adoc; then \
		touch $$</langs/$(NATLANG)/index.adoc; fi
	@cp -upr $$</langs/$(NATLANG)/* $$@ 2>/dev/null; 
	@$(MAKE_DIR)/massage-course $$@

endef

$(eval $(foreach pathway,$(the-pathways),$(call make-copy-pathway-rule,$(pathway))))
