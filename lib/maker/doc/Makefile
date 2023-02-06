adoc_files := *.adoc

png_files := *.png

index.html: $(adoc_files) $(png_files)
	asciidoctor -a linkcss index.adoc
