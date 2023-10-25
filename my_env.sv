`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   my_driver_in drv_in;
   my_monitor_in i_mon;
   
   my_monitor_out o_mon;

   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      drv_in = my_driver_in::type_id::create("drv_in", this); 
      i_mon = my_monitor_in::type_id::create("i_mon", this);
      o_mon = my_monitor_out::type_id::create("o_mon", this);
   endfunction

   `uvm_component_utils(my_env)
endclass
`endif
