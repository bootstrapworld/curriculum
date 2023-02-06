adoc_files := *.adoc

svg_files := *.svg

index.html: $(adoc_files) $(svg_files)
	asciidoctor -a linkcss index.adoc
