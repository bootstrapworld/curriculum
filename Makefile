# created 2023-01-15
# last modified 2023-02-23

# To override any of these, set them at the make call, e.g.,
# make NATLANG=es-mx
# make SPRING=spring YEAR=2022

export NATLANG ?= en-us

# these shd be in a separate file? Or possibly determined astronomically?
export SEMESTER ?= fall
export YEAR ?= 2023

# don't change below this

export MAKE_DIR := lib/maker/

include lib/maker/Makefile.all
