reports:
	@for f in *-student.adoc; do \
	  echo Converting $$f; \
	  ./expand-questionnaire.rkt $$f; \
	  g=$$(cat .expanded-file); \
	  echo Generating local HTML version of $$g; \
	  asciidoctor -a linkcss -a stylesheet=./questionnaire.css $$g; \
	done

questionnaires:
	@for f in *-admin.adoc; do \
	  ./make-questionnaire.rkt $$f; \
	done

