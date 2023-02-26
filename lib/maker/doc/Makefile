# last modified 2023-02-26

adoc_files := *.adoc

svg_files := *.svg

all: index.html

index.html: $(adoc_files) $(svg_files)
	asciidoctor -a linkcss index.adoc
