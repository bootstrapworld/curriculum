# created 2023-01-17
# last modified 2023-02-13

asc-file = $(dir $1).cached/.$(patsubst %.adoc,%.asc,$(notdir $1))

pdf-file = $(dir $1)$(patsubst %.adoc,%.pdf,$(notdir $1))
