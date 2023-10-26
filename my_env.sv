`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

   my_agent_in   i_agt;
   my_agent_out  o_agt;
   my_model mdl;
   my_scoreboard scb;
   uvm_tlm_analysis_fifo #(my_transaction_in) agt_mdl_fifo_in;
   uvm_tlm_analysis_fifo #(my_transaction_out) agt_scb_fifo;
   uvm_tlm_analysis_fifo #(my_transaction_out) mdl_scb_fifo;
   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      i_agt = my_agent_in::type_id::create("i_agt", this);
      o_agt = my_agent_out::type_id::create("o_agt", this);
      i_agt.is_active = UVM_ACTIVE;
      mdl = my_model::type_id::create("mdl", this);
      scb = my_scoreboard::type_id::create("scb", this);
      agt_mdl_fifo_in = new("agt_mdl_fifo_in", this);
      agt_scb_fifo = new("agt_scb_fifo",this);
      mdl_scb_fifo = new("mdl_scb_fifo", this);
      // o_agt.is_active = UVM_PASSIVE;
   endfunction
   extern virtual function void connect_phase(uvm_phase phase);
   `uvm_component_utils(my_env)
endclass
   function void my_env::connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      i_agt.ap_in.connect(agt_mdl_fifo_in.analysis_export);
      mdl.port_in.connect(agt_mdl_fifo_in.blocking_get_export);

      mdl.ap_out.connect(mdl_scb_fifo.analysis_export);
      scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
      o_agt.ap_out.connect(agt_scb_fifo.analysis_export);
      scb.act_port.connect(agt_scb_fifo.blocking_get_export); 
   endfunction
`endif
