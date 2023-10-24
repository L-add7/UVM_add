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
   extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
   my_transaction tr;
   phase.raise_objection(this);
   vif.a <= 8'b0;
   vif.b <= 8'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   for(int i = 0; i < 2; i++) begin 
      tr = new("tr");
      assert(tr.randomize());
      `uvm_info("tr", $sformatf("tr.add1 = 0x%0h", tr.add1 ), UVM_LOW);
      `uvm_info("tr", $sformatf("tr.add2 = 0x%0h", tr.add2 ), UVM_LOW);
      drive_one_pkt(tr);
      // `uvm_info("vif", $sformatf("vif.c = 0x%0h", vif.c ), UVM_LOW);
   end
   repeat(5) @(posedge vif.clk);
   phase.drop_objection(this);
endtask

task my_driver::drive_one_pkt(my_transaction tr);
   bit [95:0] tmp_data1;
   bit [95:0] tmp_data2;
   bit [7:0] data_add1[$];
   bit [7:0] data_add2[$];

   tmp_data1 = tr.add1;
   tmp_data2 = tr.add2;

   for(int i = 0; i < 12; i++) begin
      data_add1.push_back(tmp_data1[7:0]);
      // vif.a <= tmp_data1[7:0];
      tmp_data1 = (tmp_data1 >> 8);
      data_add2.push_back(tmp_data2[7:0]);
      // vif.b <= tmp_data2[7:0];
      tmp_data2 = (tmp_data2 >> 8);

   end


   // `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   // repeat(3) @(posedge vif.clk);

   while(data_add1.size() > 0 && data_add2.size() > 0) begin
      @(posedge vif.clk);
      vif.a <= data_add1.pop_front(); 
      `uvm_info("vif", $sformatf("vif.a = 0x%0h", vif.a ), UVM_LOW);
      vif.b <= data_add2.pop_front(); 
      `uvm_info("vif", $sformatf("vif.b = 0x%0h", vif.b ), UVM_LOW);
   end

   // @(posedge vif.clk);
   `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask



`endif
