# last modified 2023-02-23

adoc_files := *.adoc

svg_files := *.svg

all: index.html makeitso-message.html

index.html: $(adoc_files) $(svg_files)
	asciidoctor -a linkcss index.adoc

makeitso-message.html: makeitso-message.adoc
	asciidoctor -a linkcss $<
