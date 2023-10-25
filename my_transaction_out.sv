`ifndef MY_TRANSACTION_OUT__SV
`define MY_TRANSACTION_OUT__SV

class my_transaction_out extends uvm_sequence_item;

   rand bit [107:0]      sum;

   `uvm_object_utils(my_transaction_out)


   function new(string name = "my_transaction_out");
      super.new(name);
   endfunction

   function void my_print();
      $display("sum = %0h",sum);
   endfunction

endclass



`endif
