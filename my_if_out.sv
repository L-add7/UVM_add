`ifndef MY_IF_OUT__SV
`define MY_IF_OUT__SV


interface my_if_out(input clk, input rst_n);

   logic [8:0] c;
   logic       valid;  
endinterface

`endif