`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   my_agent_in   i_agt;
   my_agent_out  o_agt;
   my_model mdl;
   uvm_tlm_analysis_fifo #(my_transaction_in) agt_mdl_fifo_in;
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      i_agt = my_agent_in::type_id::create("i_agt", this);
      o_agt = my_agent_out::type_id::create("o_agt", this);
      i_agt.is_active = UVM_ACTIVE;
      mdl = my_model::type_id::create("mdl", this);
      agt_mdl_fifo_in = new("agt_mdl_fifo_in", this);
      // o_agt.is_active = UVM_PASSIVE;
   endfunction
   extern virtual function void connect_phase(uvm_phase phase);
   `uvm_component_utils(my_env)
endclass
   function void my_env::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      i_agt.ap_in.connect(agt_mdl_fifo_in.analysis_export);
      mdl.port_in.connect(agt_mdl_fifo_in.blocking_get_export);
   endfunction
`endif
