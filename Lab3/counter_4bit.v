`include "jkFlipflop.v"

module counter(clk,Q,QC);
output [3:0] Q;
output [3:0] QC;
input clk;
jk j1(Q[0],QC[0],1'b1,1'b1,clk);
jk j2(Q[1],QC[1],Q[0],Q[0],clk);
jk j3(Q[2],QC[2],Q[0]&Q[1],Q[0]&Q[1],clk);
jk j4(Q[3],QC[3],Q[0]&Q[1]&Q[2],Q[0]&Q[1]&Q[2],clk);

endmodule


module tb;

wire [3:0] q;
wire [3:0] qc;
reg clk;

counter cnt(clk,q,qc);

always@(*)
#5 clk<=~clk;

initial
begin
$monitor(,$time,"Q=%b",q);
#0 clk=1'b0;
#100 $finish;
end
endmodule

