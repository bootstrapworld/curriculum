# last modified 2023-02-28

# to override any of these, set them at the make call, e.g.,
#
# make NATLANG=es-mx
# make SEMESTER=spring YEAR=2022
# make ASCIIDOCTOR_NODE=yes

export NATLANG ?= en-us

# but perhaps putting the following defaults here isn't great.
# Maybe they should be in a separate customization file?
# Or possibly determined astronomically?

export SEMESTER ?= fall
export YEAR ?= 2023

# set to nonempty if you want to use the Node (rather than Ruby) version of Asciidoctor.
# It isn't bugfree though

export ASCIIDOCTOR_NODE

# don't change below this

include lib/maker/Makefile.all
