`include "shiftregister.v"

module serialAdder(clk,control,si_b,Q);

input clk,control;
input [3:0] si_b;
output [3:0] Q;
wire [3:0] qb,qa;

shiftreg sftB(control,si_b,clk,qb);
shiftreg sftA(control,4'd0,clk,qa);




