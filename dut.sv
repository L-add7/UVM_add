module dut(clk,
	rst_n,
	a,
	b,
	c);
input 		          clk;
input 		          rst_n;
input  [7:0]          a;
input  [7:0]          b;
output [8:0]	      c;

reg	   [8:0]          c_r;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		c_r <= 9'b0;
	end
	else begin
		c_r <= a + b;
	end
end


assign c = c_r;
endmodule

