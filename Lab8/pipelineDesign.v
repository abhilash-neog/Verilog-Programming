`include "encoder.v"
`include "alu.v"
`include "parityGenerator.v"


module pipelinereg1(clk, opcode, A, B, opout, AOut, BOut);
  input [2:0] opcode;
  input [3:0] A, B;
  input clk;
  output  [2:0] opout;
  output  [3:0] AOut, BOut;
  reg [2:0] OpOut;
  reg [3:0] AOut, BOut;
  always  @ (posedge clk) begin
    opout <= opcode;
    AOut  <= A;
    BOut  <= B;
  end
endmodule


module pipelinereg2(clk, X,XOut);
  input [3:0] X;
  output [3:0] XOut;
  input clk;
  reg [3:0] XOut;
  
  always  @ (posedge clk) begin
    XOut <= X;
  end
endmodule

module fetch(func,opcode,clk,A,B);//stage 1
input [7:0] func;input clk;
input [3:0] A,B;
output [2:0] opcode;
wire [3:0] AOut,BOut;
wire [2:0] opout;
wire [3:0] X;
wire [3:0] XOut;
wire cout;
encoder enc(func,opcode);
pipelinereg1 pp1(clk,opcode,A,B,opout,AOut,BOut);//fetch stage
alu al(opout,AOut,BOut,X,cout);//execute
pipelinereg2 pp2(clk,X,XOut);



