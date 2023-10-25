`ifndef MY_TRANSACTION_IN__SV
`define MY_TRANSACTION_IN__SV

class my_transaction_in extends uvm_sequence_item;

   rand bit [95:0]      add1;
   rand bit [95:0]      add2;

   `uvm_object_utils(my_transaction_in)


   function new(string name = "my_transaction_in");
      super.new(name);
   endfunction

   function void my_print();
      $display("add1 = %0h",add1);
      $display("add2 = %0h",add2);
   endfunction

endclass



`endif
