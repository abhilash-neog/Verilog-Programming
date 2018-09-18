module nonblocking(in, clk, out);
input in, clk;
output out;
reg q1, q2, out;
always @ (posedge clk)
begin
q1 <= in;
q2 <= q1;
out <= q2;
end
endmodule

module test;
	reg ix,clkx;
	wire outx;
	
	nonblocking n1(ix,clkx,outx);
	initial	
	$monitor($time, "in  = %h clk = %b out = %h",ix,clkx,outx);
	//always never present in testbench
	initial 
	begin
	forever 
	begin
	clkx=0;
	#5 clkx=1;
	#5 clkx=0;
	end
	end
	initial 
	begin
	ix=0; 
	#4
	ix=1;
	#50
	ix=1; 
	#20
	ix=0;
	#100 $finish;
	end
	
endmodule

