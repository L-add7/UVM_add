`ifndef MY_AGENT_IN__SV
`define MY_AGENT_IN__SV

class my_agent_in extends uvm_agent ;
   my_sequencer_in  sqr_in;
   my_driver_in     drv_in;
   my_monitor_in    mon_in;
   
   uvm_analysis_port #(my_transaction_in)  ap_in;
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agent_in)
endclass 


function void my_agent_in::build_phase(uvm_phase phase);
   super.build_phase(phase);
   if (is_active == UVM_ACTIVE) begin
       sqr_in = my_sequencer_in::type_id::create("sqr_in", this);
       drv_in = my_driver_in::type_id::create("drv_in", this);
   end
   mon_in = my_monitor_in::type_id::create("mon_in", this);
endfunction 

function void my_agent_in::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   if (is_active == UVM_ACTIVE) begin
      drv_in.seq_item_port.connect(sqr_in.seq_item_export);
   end
   ap_in = mon_in.ap_in;
endfunction

`endif

