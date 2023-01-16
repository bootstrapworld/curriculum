# created 2023-01-15
# last modified 2023-01-16

pyret-lessons := $(wildcard lessons/**/langs/$(NATLANG))

pyret-distribution-lessons := $(patsubst %,distribution/$(NATLANG)/lessons/%/., \
                                $(notdir \
                                  $(patsubst %/langs/$(NATLANG),%, \
                                    $(pyret-lessons))))

lesson-bare-name = $(notdir $(patsubst %/langs/$(NATLANG),%,$1))

copy-lessons: $(pyret-distribution-lessons)

define make-copy-lesson-rule
distribution/$(NATLANG)/lessons/$(call lesson-bare-name,$1)/.: $1
	mkdir -p $$@
	touch $$@
	cp -upr $$</* $$@
	$(MAKE_DIR)/massage-distribution-lesson $$@

endef

$(eval $(foreach lesson,$(pyret-lessons),$(call make-copy-lesson-rule,$(lesson))))
