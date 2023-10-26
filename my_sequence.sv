`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction_in);
   my_transaction_in m_trans_in;

   function new(string name= "my_sequence");
      super.new(name);
   endfunction

   virtual task body();
      repeat (10) begin
         `uvm_do(m_trans_in)
      end
      #1000;
   endtask

   `uvm_object_utils(my_sequence)
endclass
`endif
