reports:
	@for f in *-student.adoc; do \
	  echo converting $$f; \
	  sanitize.rkt $$f; \
	  g=$$(basename $$f -student.adoc)-final.adoc; \
	  echo doing $$g; \
	  asciidoctor -a linkcss -a stylesheet=./questionnaire.css $$g; \
	done

student-files:
	@for f in *-admin.adoc; do \
	  echo converting $$f; \
	  ./make-questionnaire.rkt $$f; \
	done

