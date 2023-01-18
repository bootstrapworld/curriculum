# created 2023-01-17
# last modified 2023-01-17

asc-file = $(dir $1).cached/.$(patsubst %.adoc,%.asc,$(notdir $1))
