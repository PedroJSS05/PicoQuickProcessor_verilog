MAIN = Main/top.v
TB = Main/tb_picoquickprocessor.v
COMPONENTS = $(wildcard Componentes/*.v)

VVP = top.vvp
VCD = top.vcd

.PHONY: all compile run analyze clean

all: compile run analyze clean

compile: $(MAIN) $(TB) $(COMPONENTS)
	iverilog -o $(VVP) $^

run: $(VVP)
	vvp $<

analyze: $(VCD)
	gtkwave $<

clean: $(VVP) $(VCD)
ifeq ($(OS), Windows_NT)
	del $^
else
	rm -f $^
endif
