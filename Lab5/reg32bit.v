//synchronous clear
module d_ff(q,d,clk,reset);
output [3:0] q; // output data
input [3:0] d; // input data
input clk,reset;
reg [3:0] q;
always @(posedge clk or negedge reset)
begin
if (reset)
q=d;
else
q=4'b0000;
end
endmodule

module reg_32bit(q,d,clk,reset);
 output [31:0]q; // output data
 input [31:0]d; // input data
 input clk,reset; // clock and clear
 genvar j; 
 generate  for (j=0; j<32;j=j+4) begin: mux_loop
 d_ff df(q[j+3:j],d[j+3:j],clk,reset); 
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
$monitor(,$time,"clk=%b out=%b inp=%b reset=%b",clk,q,d,reset);
end

initial
begin
$dumpfile("reg32bit.vcd");
$dumpvars();
end

initial 
begin 
#0  clk = 1'b1; reset = 1'b1; d = 32'hFFFFFFFF;
#1  reset = 1'b0;
#20 reset=1'b1; 
#20 d=32'hAFAFAFAF; 
#40 reset = 1'b0;
#80 reset = 1'b1;
#120 reset = 1'b0;
#150 reset = 1'b1;
#200 $finish; 
end 
endmodule 