`include "encoder.v"
`include "alu.v"
`include "parityGenerator.v"


module pipelinereg1(clk, opcode, A, B, opout, AOut, BOut);
  input [2:0] opcode;
  input [3:0] A, B;
  input clk;
  output  [2:0] opout;
  output  [3:0] AOut, BOut;
  reg [2:0] opout;
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

module datapath(func,clk,A,B,result);
input [7:0] func;input clk;
input [3:0] A,B;
output result;
wire [2:0] opcode;
wire [3:0] AOut,BOut;
wire [2:0] opout;
wire [3:0] X;
wire [3:0] XOut;
wire cout;
encoder enc(func,opcode);
pipelinereg1 pp1(clk,opcode,A,B,opout,AOut,BOut);//fetch stage
alu al(opout,AOut,BOut,X,cout);//execute
pipelinereg2 pp2(clk,X,XOut);
paritygenerator pg(XOut,result);//parity

endmodule

module testbench;
  reg clock;
  reg [7:0] FuncCode;
  reg [3:0] A, B;
  wire  result;
  datapath  mod(FuncCode,clock, A, B, result);
  initial begin
    $monitor($time, " A = %b, B = %b, Function Code = %b, OpCode = %b, AOut = %b, BOut = %b, OpOut = %b, X = %b, Carry = %b, XOut = %b, Output = %b.", A, B, FuncCode, mod.opcode, mod.AOut, mod.BOut, mod.opout, mod.X, mod.cout, mod.XOut, result);
    #0  clock = 1'b1;
    #4  A = 4'b0101; B = 4'b1110;  FuncCode = 8'b10000000;
    #20 FuncCode = 8'b01000000;
    #20 FuncCode = 8'b00100000;
    #20 FuncCode = 8'b00010000;
    #20 FuncCode = 8'b00001000;
    #20 FuncCode = 8'b00000100;
    #20 FuncCode = 8'b00000010;
    #20 FuncCode = 8'b00000001;
    #50 $finish;
  end
  always
    #2  clock = ~clock;
endmodule



