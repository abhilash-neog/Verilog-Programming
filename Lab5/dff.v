//asynchronous clear; 
module DFF (Q,QN,D,Clock,ClearN);
 output Q,QN; // data output
 input D; // data input
 input Clock,Clear;
 reg Q;
 always @(posedge Clock, negedge ClearN)
 begin
 if (~Clear)
 Q=1'b0;
 else
 Q=D;
 end
 assign QN = ~Q;
endmodule

//synchronous clear
module DFFSync (Q,QN,D,Clock,ClearN);
 output Q,QN; // data output
 input D; // data input
 input Clock,Clear;
 reg Q;
 always @(posedge Clock)
 begin
 if (~Clear)
 Q=1'b0;
 else
 Q=D;
 end
 assign QN = ~Q;
endmodule

module Register4(Q3,Q2,Q1,Q0,D3,D2,D1,D0,Clock,ClearN);
 output Q3,Q2,Q1,Q0; // output data
 input D3,D2,D1,D0; // input data
 input Clock,ClearN; // clock and clear
 DFF FF0 (Q0,D0,Clock,ClearN);
 DFF FF1 (Q1,D1,Clock,ClearN);
 DFF FF2 (Q2,D2,Clock,ClearN);
 DFF FF3 (Q3,D3,Clock,ClearN);
endmodule

module reg_32bit(Q,D,Clock,ClearN);
 output [31:0]Q; // output data
 input [31:0]D; // input data
 input Clock,ClearN; // clock and clear
 genvar j; 
 generate  for (j=0; j<32;j=j+4) begin: mux_loop
 DFF FF0 (Q[j+3:j],D0[j+3:j],Clock,ClearN); 
 end
 endgenerate
endmodule

module tb32reg; 
reg [31:0] d; 
reg clk,reset; 
wire [31:0] q; 
reg_32bit R(q,d,clk,reset); 
always @(clk) 
#5 clk<=~clk; 
initial 
begin 
clk= 1'b1; 
reset=1'b0;//reset the register 
#20 reset=1'b1; 
#20 d=32'hAFAFAFAF; 
#200 $finish; 
end 
endmodule 