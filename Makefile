# To override any of these, set them at the make call, e.g.,
#
# make SEMESTER=spring YEAR=2022

export SEMESTER := fall

export YEAR := $(shell date +%Y)

# default NATLANG is en-us. To override: make NATLANG=es-mx

export NATLANG := en-us

# set ASCIIDOCTOR_NODE to nonempty if you want to use the Node (rather than
# Ruby) version of Asciidoctor. It isn't bugfree yet

# make ASCIIDOCTOR_NODE=yes

# When it does become bugfree and you want it by default, uncomment

# export ASCIIDOCTOR_NODE := yes

############################################################################

# don't change below this

include lib/maker/Makefile.all
