# created 2023-01-15
# last modified 2023-01-19

initialization: distribution/$(NATLANG)/extlib/mathjax/.
	@mkdir -p $(PROGDIR)
	@mkdir -p distribution/$(NATLANG)/lib
	@cp -upr shared/langs/en-us/* $(PROGDIR)
	@cp -upr shared/langs/en-us/*.css distribution/$(NATLANG)/lib
	@if test $(NATLANG) != en-us -a -d shared/langs/$(NATLANG); then \
		cp -upr shared/langs/$(NATLANG)/* $(PROGDIR); fi
	@mkdir -p distribution/$(NATLANG)/lib/Badges
	@mkdir -p distribution/$(NATLANG)/lib/images
	@cp -upr $(PROGDIR)/Badges/* distribution/$(NATLANG)/lib/Badges
	@cp -upr $(PROGDIR)/images/* distribution/$(NATLANG)/lib/images
	@cp -upr shared/langs/en-us/docroot/* distribution/$(NATLANG)
	@if test $(NATLANG) != en-us -a -d shared/langs/$(NATLANG)/docroot; then \
		cp -upr shared/langs/$(NATLANG)/docroot/* distribution/$(NATLANG); fi
	@cp -p lib/*.html $(PROGDIR)
	@cp -p lib/*.rkt $(PROGDIR)
	@cp -p lib/*.sh $(PROGDIR)
	@cp -p lib/ano* $(PROGDIR)
	@cp -p lib/check* $(PROGDIR)
	@cp -p lib/.hta* $(PROGDIR)
	@cp -p lib/*.css distribution/$(NATLANG)/lib
	@cp -p lib/*.js* distribution/$(NATLANG)/lib
	@cp -p lib/*.less distribution/$(NATLANG)/lib
	@cp -p lib/*.png distribution/$(NATLANG)/lib
	@for f in distribution/$(NATLANG)/lib/*.less; do \
		if test -f "$$f"; then \
		node_modules/less/bin/lessc "$$f" "$${f%.less}.css"; fi; done
	@cp -p shared/langs/en-us/*.css distribution/$(NATLANG)/lib
	@mkdir -p distribution/$(NATLANG)/.cached
	@rm -f $(ADOC_INPUT) $(ADOC_POSTPROC_PWYINDEP_INPUT) \
		$(RELEVANT_LESSONS_INPUT)
	@touch $(RELEVANT_LESSONS_INPUT)
	@echo "{\"htmlFileSpecs\": [ \"ignoreElement\"" > $(PUPPETEER_INPUT)
	@echo '(' > $(ADOCABLES_INPUT)

#fixme: once logic is set, split above into actual rules to reduce re-doing

node_modules/mathjax:
	npm install

distribution/$(NATLANG)/extlib/mathjax/.: node_modules/mathjax
	@mkdir -p $@
	@cp -upr node_modules/mathjax/* $@
	@cp -p lib/mathjaxlocal.js $@/config/local
	@rm -fr $@/[CLRptu]*
