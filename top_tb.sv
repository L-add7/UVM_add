`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;

`include "my_if.sv"
`include "my_driver.sv"


module top_tb;
reg 		          clk;
reg 		          rst_n;
reg  [7:0]          a;
reg  [7:0]          b;
wire [8:0]	        c;


my_if mif(clk,rst_n);
// my_if output_if(clk,rst_n);

dut my_dut(
    .clk(clk),
    .rst_n(rst_n),
    .a(mif.a),
    .b(mif.b),
    .c(mif.c)
);

initial begin
    uvm_config_db# (virtual my_if)::set(null,"uvm_test_top","vif",mif);
end

initial begin
    run_test("my_driver");
end

initial begin
    clk = 0;
    forever begin
        #100 clk = ~clk;
    end
end

initial begin
    rst_n = 0;
    #1000
    rst_n = 1;
end
endmodule