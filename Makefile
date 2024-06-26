
# Copyright © 2024, Julian Scheffers, see LICENSE for info

.PHONY: all cmod vhdl sim wave clean

MAKEFLAGS += --silent

SIM  = $(shell cd hdl/nebula; find sim -name '*.scala' | sed 's|\.scala$$||')
WAVE = $(shell cd hdl/nebula; find sim -name '*.scala' | sed 's|\.scala$$|.wave|')
HDL  = $(shell find hdl -name '*.scala')

.PHONY: $(SIM)

all:
	echo '$(SIM)'
	echo '$(WAVE)'

cmod:
	sbt "runMain nebula.nest.CmodA7Verilog"

$(SIM):
	sbt "runMain nebula.sim.$(@F)"

$(WAVE):
	sbt "runMain nebula.sim.$(shell echo '$(@F)' | sed 's|.wave$$||g')"
	gtkwave "simWorkspace/$(shell echo '$(@F)' | sed 's|.wave$$||g')$$/wave.fst"

clean:
	rm -rf tmp target simWorkspace project gen
