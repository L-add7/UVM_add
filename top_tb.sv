`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;

`include "my_if_in.sv"
`include "my_if_out.sv"
`include "my_transaction_in.sv"
`include "my_transaction_out.sv"
`include "my_sequencer_in.sv"
`include "my_driver_in.sv"
// `include "my_driver_out.sv"
`include "my_monitor_in.sv"
`include "my_monitor_out.sv"
`include "my_agent_in.sv"
`include "my_agent_out.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"


module top_tb;
reg 		          clk;
reg 		          rst_n;
reg  [7:0]            a;
reg  [7:0]            b;
reg                   valid;               
wire [8:0]	          c;


my_if_in mif_in(clk,rst_n);
my_if_out mif_out(clk,rst_n);
// my_if output_if(clk,rst_n);

dut my_dut(
    .clk(clk),
    .rst_n(rst_n),
    .a(mif_in.a),
    .b(mif_in.b),
    .valid_in(mif_in.valid),
    .c(mif_out.c),
    .valid_out(mif_out.valid)
);

initial begin
    uvm_config_db# (virtual my_if_in)::set(null,"uvm_test_top.i_agt.drv_in","mif_in",mif_in);
    uvm_config_db# (virtual my_if_in)::set(null,"uvm_test_top.i_agt.mon_in","mif_in",mif_in);

    uvm_config_db# (virtual my_if_out)::set(null,"uvm_test_top.o_agt.mon_out","mif_out",mif_out);

end

initial begin
    run_test("my_env");
end

initial begin
    clk = 0;
    forever begin
        #100 clk = ~clk;
    end
end

// always @(posedge clk)begin
//     `uvm_info("mif_out", $sformatf("mif_out.c = 0x%0h", mif_out.c ), UVM_LOW);
// end


initial begin
    rst_n = 0;
    #1000
    rst_n = 1;
end
endmodule