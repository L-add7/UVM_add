module dut(clk,
	rst_n,
	a,
	b,
	c,
	valid_in,
	valid_out);
input 		          clk;
input 		          rst_n;
input  [7:0]          a;
input  [7:0]          b;
input			      valid_in;
output [8:0]	      c;
output 		reg		  valid_out;

reg	   [8:0]          c_r;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		c_r <= 9'b0;
		valid_out<=1'b0;
	end
	else if(valid_in)begin
		c_r <= a + b;
		valid_out<=1'b1;
	end
	else begin
		c_r <= c_r;
		valid_out<=1'b0;
	end
end


assign c = c_r;
endmodule

