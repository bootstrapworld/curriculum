# default SEMESTER is fall, default YEAR is current year. To override these,
# set them at the make call, eg:
#
# make SEMESTER=spring YEAR=2022

export SEMESTER := fall

export YEAR := 2026

# default NATLANG is en-us. To override: make NATLANG=es-mx

export NATLANG := en-us

# make ASCIIDOCTOR_NODE=yes
#
# if you want to use the Node (rather than Ruby) version of Asciidoctor. It
# isn't bugfree yet

# When it does become bugfree and you want it by default, uncomment

# export ASCIIDOCTOR_NODE := yes

# make DEBUGADOC=yes
#
# if you want to run Asciidoctor individually on each intermediate .asc file so
# as to locate AsciiDoc errors. By default, Asciidoctor runs on all .asc files in
# a single batch: this is very fast but no help in identifying which file
# resulted in an AsciiDoc error

############################################################################

# don't change below this

include lib/maker/Makefile.all
