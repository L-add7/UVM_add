`ifndef MY_SEQUENCER_IN__SV
`define MY_SEQUENCER_IN__SV

class my_sequencer_in extends uvm_sequencer #(my_transaction_in);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(my_sequencer_in)
endclass

`endif
