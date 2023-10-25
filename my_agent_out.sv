`ifndef MY_AGENT_OUT__SV
`define MY_AGENT_OUT__SV

class my_agent_out extends uvm_agent ;
   // my_driver_in     drv_in;
   my_monitor_out    mon_out;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agent_out)
endclass 


function void my_agent_out::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // if (is_active == UVM_ACTIVE) begin
   //     drv_in = my_driver::type_id::create("drv_in", this);
   // end
   mon_out = my_monitor_out::type_id::create("mon_out", this);
endfunction 

function void my_agent_out::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction

`endif

