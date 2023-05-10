# last modified 2023-03-03

adoc_files := *.adoc

svg_files := *.svg

all: index.html

index.html: $(adoc_files) $(svg_files)
	asciidoctor -a linkcss -a icons=font index.adoc
