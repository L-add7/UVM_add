#---------------------------------------------------------------------------
# files options
#---------------------------------------------------------------------------
DFILES  += dut.sv
VFILES  += top_tb.sv


#---------------------------------------------------------------------------
# tool options
#---------------------------------------------------------------------------
TOOL_CMD	= vcs -full64 -cpp g++-11 -cc gcc-11 -LDFLAGS -Wl,--no-as-needed 
COMP_OPT	= -sverilog -debug_access+all -lca -kdb -fsdb +define+FSDB -timescale=1ns/1ps 
UVM_OPT		= -ntb_opts uvm-1.2

uvm:comp run

comp:
	$(TOOL_CMD) $(COMP_OPT) $(UVM_OPT) $(DFILES) $(VFILES)

run:
	./simv +UVM_NO_RELNOTES
	
rung:
	./simv +UVM_NO_RELNOTES -gui=verdi

verdi:
	verdi tb.fsdb

clean:
	rm -rf csrc simv simv.daidir *.fsdb novas.* ucli.key
	rm -rf *.log* *.vpd *.h urgReport verdiLog

