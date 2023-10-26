`ifndef MY_DRIVER_IN__SV
`define MY_DRIVER_IN__SV
class my_driver_in extends uvm_driver;

   virtual my_if_in mif_in;
   `uvm_component_utils(my_driver_in);
   function new(string name = "my_driver_in", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if_in)::get(this, "", "mif_in", mif_in))
         `uvm_fatal("my_driver_in", "virtual interface must be set for mif_in!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction_in tr_in);
endclass

task my_driver_in::main_phase(uvm_phase phase);
   my_transaction_in tr_in;
   phase.raise_objection(this);
   mif_in.a <= 8'b0;
   mif_in.b <= 8'b0;
   mif_in.valid <= 1'b0;
   while(!mif_in.rst_n)
      @(posedge mif_in.clk);
   for(int i = 0; i < 2; i++) begin 
      tr_in = new("tr_in");
      assert(tr_in.randomize());
      // `uvm_info("tr", $sformatf("tr.add1 = 0x%0h", tr.add1 ), UVM_LOW);
      // `uvm_info("tr", $sformatf("tr.add2 = 0x%0h", tr.add2 ), UVM_LOW);
      drive_one_pkt(tr_in);
      // `uvm_info("mif_in", $sformatf("mif_in.c = 0x%0h", mif_in.c ), UVM_LOW);
   end
   repeat(5) @(posedge mif_in.clk);
   phase.drop_objection(this);
endtask

task my_driver_in::drive_one_pkt(my_transaction_in tr_in);
   bit [95:0] tmp_data1;
   bit [95:0] tmp_data2;
   bit [7:0] data_add1[$];
   bit [7:0] data_add2[$];

   tmp_data1 = tr_in.add1;
   tmp_data2 = tr_in.add2;

   for(int i = 0; i < 12; i++) begin
      data_add1.push_back(tmp_data1[7:0]);
      // mif_in.a <= tmp_data1[7:0];
      tmp_data1 = (tmp_data1 >> 8);
      data_add2.push_back(tmp_data2[7:0]);
      // mif_in.b <= tmp_data2[7:0];
      tmp_data2 = (tmp_data2 >> 8);

   end


   `uvm_info("my_driver_in", "begin to drive one pkt", UVM_LOW);
   // repeat(3) @(posedge mif_in.clk);

   while(data_add1.size() > 0 && data_add2.size() > 0) begin
      @(posedge mif_in.clk);
      mif_in.valid <= 1'b1;
      mif_in.a <= data_add1.pop_front(); 
      mif_in.b <= data_add2.pop_front(); 
   end
   @(posedge mif_in.clk);
      mif_in.valid <= 1'b0;
   // @(posedge mif_in.clk);
   `uvm_info("my_driver_in", "end drive one pkt", UVM_LOW);
endtask



`endif
