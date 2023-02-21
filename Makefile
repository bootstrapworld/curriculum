# created 2023-01-15
# last modified 2023-01-19

export NATLANG ?= en-us

# these shd be in a separate file, and possibly deduced
export SEMESTER = fall
export YEAR = 2023

export MAKE_DIR := lib/maker/

include lib/maker/Makefile.all
