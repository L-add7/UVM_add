`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver;

   virtual my_if vif;
   `uvm_component_utils(my_driver);
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   // extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("my_driver","main_phase is called",UVM_LOW);
    while(!vif.rst_n)
      @(posedge vif.clk);
         for(int i = 0 ; i < 256 ; i++)begin
            @(posedge vif.clk)
               vif.a  <= $urandom_range(0,255);
               vif.b  <= $urandom_range(0,255);
               `uvm_info("my_driver","data is drived",UVM_LOW);
         end
   phase.drop_objection(this);
endtask


`endif
