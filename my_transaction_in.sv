`ifndef MY_TRANSACTION_IN__SV
`define MY_TRANSACTION_IN__SV

class my_transaction_in extends uvm_sequence_item;

   rand bit [95:0]      add1;
   rand bit [95:0]      add2;

   `uvm_object_utils_begin(my_transaction_in)
      `uvm_field_int(add1, UVM_ALL_ON)
      `uvm_field_int(add2, UVM_ALL_ON)
   `uvm_object_utils_end


   function new(string name = "my_transaction_in");
      super.new(name);
   endfunction

   // function void my_print();
   //    $display("add1 = %0h",add1);
   //    $display("add2 = %0h",add2);
   // endfunction

   // function void my_copy(my_transaction_in tr_in);
   // if(tr_in == null)
   //    `uvm_fatal("my_transaction", "tr is null!!!!")
   // add1 = tr_in.add1;
   // add2 = tr_in.add2;
   // endfunction
endclass



`endif
