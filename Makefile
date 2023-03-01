# last modified 2023-03-01

# to override any of these, set them at the make call, e.g.,
#
# make NATLANG=es-mx
# make SEMESTER=spring YEAR=2022
# make ASCIIDOCTOR_NODE=yes

export NATLANG ?= en-us

export SEMESTER ?= fall

export YEAR ?= $(shell date +%Y)-BETA

# set ASCIIDOCTOR_NODE to nonempty if you want to use the Node (rather than
# Ruby) version of Asciidoctor. It isn't bugfree yet

# export ASCIIDOCTOR_NODE

############################################################################

# don't change below this

include lib/maker/Makefile.all
