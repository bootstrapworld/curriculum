# last modified 2023-03-01

# asc-file of wherever/it/is/file.adoc is wherever/it/is/.cached/.file.asc

asc-file = $(dir $1).cached/.$(patsubst %.adoc,%.asc,$(notdir $1))

# pdf-file of wherever/it/is/file.adoc is wherever/it/is/file.pdf

pdf-file = $(dir $1)$(patsubst %.adoc,%.pdf,$(notdir $1))
