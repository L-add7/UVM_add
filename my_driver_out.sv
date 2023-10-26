`ifndef MY_DRIVER_OUT__SV
`define MY_DRIVER_OUT__SV
class my_driver_out extends uvm_driver;

   virtual my_if_out mif_out;
   `uvm_component_utils(my_driver_out);
   function new(string name = "my_driver_out", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if_out)::get(this, "", "mif_out", mif_out))
         `uvm_fatal("my_driver_out", "virtual interface must be set for mif_out!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction_out tr_out);
endclass

task my_driver_out::main_phase(uvm_phase phase);
   my_transaction_out tr_out;
   phase.raise_objection(this);
   mif_out.c <= 8'b0;
   mif_out.valid <= 1'b0;
   while(!mif_out.rst_n)
      @(posedge mif_out.clk);
   for(int i = 0; i < 2; i++) begin 
      tr_out = new("tr_out");
      assert(tr_out.randomize());
      // `uvm_info("tr_out", $sformatf("tr_out.add1 = 0x%0h", tr_out.add1 ), UVM_LOW);
      // `uvm_info("tr_out", $sformatf("tr_out.add2 = 0x%0h", tr_out.add2 ), UVM_LOW);
      drive_one_pkt(tr_out);
      // `uvm_info("mif_out", $sformatf("mif_out.c = 0x%0h", mif_out.c ), UVM_LOW);
   end
   repeat(5) @(posedge mif_out.clk);
   phase.drop_objection(this);
endtask

task my_driver_out::drive_one_pkt(my_transaction_out tr_out);
   bit [107:0] tmp_data1;

   bit [8:0] data_q;


   tmp_data1 = tr_out.sum;


   for(int i = 0; i < 12; i++) begin
      data_q.push_back(tmp_data1[8:0]);
      // mif_out.a <= tmp_data1[7:0];
      tmp_data1 = (tmp_data1 >> 9);


   end


   `uvm_info("my_driver_out", "begin to drive one pkt", UVM_LOW);
   // repeat(3) @(posedge mif_out.clk);

   while(data_q.size() > 0 ) begin
      @(posedge mif_out.clk);
      mif_out.valid <= 1'b1;
      mif_out.c <= data_q.pop_front(); 
   end
   @(posedge mif_out.clk);
      mif_out.valid <= 1'b0;
   // @(posedge mif_out.clk);
   `uvm_info("my_driver_out", "end drive one pkt", UVM_LOW);
endtask



`endif
