`ifndef MY_MONITOR_IN__SV
`define MY_MONITOR_IN__SV
class my_monitor_in extends uvm_monitor;

   virtual my_if_in mif_in;
   uvm_analysis_port #(my_transaction_in)  ap_in;
   `uvm_component_utils(my_monitor_in)
   function new(string name = "my_monitor_in", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if_in)::get(this, "", "mif_in", mif_in))
         `uvm_fatal("my_monitor_in", "virtual interface must be set for mif_in!!!")
      ap_in = new("ap_in",this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction_in tr_in);
endclass

task my_monitor_in::main_phase(uvm_phase phase);
   my_transaction_in tr_in;
   while(1) begin
      tr_in = new("tr_in");
      collect_one_pkt(tr_in);
      ap_in.write(tr_in);
   end
endtask

task my_monitor_in::collect_one_pkt(my_transaction_in tr_in);
   bit[7:0] data_q1[$]; 
   bit[7:0] data_q2[$];

   while(1)begin
      @(posedge mif_in.clk)
         if(mif_in.valid) break;
   end
   `uvm_info("my_monitor_in", "begin to collect one pkt", UVM_LOW);
   while(mif_in.valid) begin
      data_q1.push_back(mif_in.a);
      data_q2.push_back(mif_in.b);
      @(posedge mif_in.clk);
   end
   for(int i = 0; i < 12; i++) begin
      tr_in.add1 = {tr_in.add1[87:0], data_q1.pop_front()};
      tr_in.add2 = {tr_in.add2[87:0], data_q2.pop_front()};
   end

   `uvm_info("my_monitor_in", "end collect one pkt, print it:", UVM_LOW);
    tr_in.print();
endtask


`endif
