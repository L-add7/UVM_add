`ifndef MY_MONITOR_OUT__SV
`define MY_MONITOR_OUT__SV
class my_monitor_out extends uvm_monitor;

   virtual my_if_out mif_out;

   `uvm_component_utils(my_monitor_out)
   function new(string name = "my_monitor_out", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if_out)::get(this, "", "mif_out", mif_out))begin
         
         `uvm_fatal("my_monitor_out", "virtual interface must be set for mif_out!!!")
      end
      // ap_out = new("ap_out",this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction_out tr_out);
endclass

task my_monitor_out::main_phase(uvm_phase phase);
   my_transaction_out tr_out;
   while(1) begin
      tr_out = new("tr_out");
      collect_one_pkt(tr_out);
      // ap_out.write(tr_out);
   end
endtask

task my_monitor_out::collect_one_pkt(my_transaction_out tr_out);
   bit[8:0] data_q1[$]; 
   while(1)begin
      @(posedge mif_out.clk)
         if(mif_out.valid) break;
   end

   `uvm_info("my_monitor", "begin to collect one pkt", UVM_LOW);
   while(mif_out.valid) begin
      data_q1.push_back(mif_out.c);
      @(posedge mif_out.clk);
   end
   //pop dmac
   for(int i = 0; i < 12; i++) begin
      tr_out.sum = {tr_out.sum[98:0], data_q1.pop_front()};
   end

   `uvm_info("my_monitor", "end collect one pkt, print it:", UVM_LOW);
    tr_out.my_print();
endtask


`endif
