reports:
	@for f in *-student.adoc; do \
	  echo converting $$f; \
	  asciidoctor -a linkcss -a stylesheet=./questionnaire.css $$f; \
	done

student-files:
	@for f in *-admin.adoc; do \
	  echo converting $$f; \
	  ./make-questionnaire.rkt $$f; \
	done

