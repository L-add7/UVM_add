`ifndef MY_MODEL__SV
`define MY_MODEL__SV

class my_model extends uvm_component;
   
   uvm_blocking_get_port #(my_transaction_in)  port_in;
   uvm_analysis_port #(my_transaction_out)  ap_out;

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);

   `uvm_component_utils(my_model)
endclass 

function my_model::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction 

function void my_model::build_phase(uvm_phase phase);
   super.build_phase(phase);
   port_in = new("port_in", this);
   ap_out = new("ap_out", this);
endfunction

task my_model::main_phase(uvm_phase phase);
   // int i = 0;   
   my_transaction_in tr_in;
   my_transaction_out tr_out;

   super.main_phase(phase);
   
   while(1) begin
      
      port_in.get(tr_in); 
      tr_out = new("tr_out");
      // I do not know why I can not use cycle
      // for(int i = 0 ; i < 12 ; i = i +1)
      //    tr_out.sum[(9*i):(9*i+8)] = tr_in.add1[(8*i):(8*i+7)]+tr_in.add2[(8*i):(8*i+7)];
      tr_out.sum[8:0]   =    tr_in.add1[(7):(0)]  +  tr_in.add2[(7):(0)]  ;
      tr_out.sum[17:9]  =    tr_in.add1[(15):(8)] +  tr_in.add2[15:8]     ;
      tr_out.sum[26:18] =    tr_in.add1[(23):(16)]+  tr_in.add2[(23):(16)];
      tr_out.sum[35:27] =    tr_in.add1[(31):(24)]+  tr_in.add2[(31):(24)];
      tr_out.sum[44:36] =    tr_in.add1[(39):(32)]+  tr_in.add2[(39):(32)];
      tr_out.sum[53:45] =    tr_in.add1[(47):(40)]+  tr_in.add2[(47):(40)];
      tr_out.sum[62:54] =    tr_in.add1[(55):(48)]+  tr_in.add2[(55):(48)];
      tr_out.sum[71:63] =    tr_in.add1[(63):(56)]+  tr_in.add2[(63):(56)];
      tr_out.sum[80:72] =    tr_in.add1[(71):(64)]+  tr_in.add2[(71):(64)];
      tr_out.sum[89:81] =    tr_in.add1[(79):(72)]+  tr_in.add2[(79):(72)];
      tr_out.sum[98:90] =    tr_in.add1[(87):(80)]+  tr_in.add2[(87):(80)];
      tr_out.sum[107:99] =   tr_in.add1[(95):(88)]+  tr_in.add2[(95):(88)];
      `uvm_info("my_model", "get one transaction, copy and print it:", UVM_LOW)
      tr_out.my_print();
      ap_out.write(tr_out);
   end

endtask
`endif
