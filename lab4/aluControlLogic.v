module ALUOp_generate(ALUOp1,ALUOp2,Op); 
input [5:0] Op; 
output ALUOp1,ALUOp2; 
//reg ALUOp1,ALUOp2; 
wire Rformat,beq;  
assign Rformat= (~Op[0])& (~Op[1])& (~Op[2])& (~Op[3])& (~Op[4])& (~Op[5]);
assign beq = (~Op[0])& (~Op[1])& (~Op[2])& (Op[3])& (~Op[4])& (~Op[5]);
assign ALUOp1 = Rformat;
assign ALUOp2 = beq;
endmodule

module aluControlLogic(Func, ALUOp,Operation);
output [2:0] Operation;
input [5:0] Func;
input [1:0] ALUOp;
wire f1,f3;
wire negAlu,negOp;
assign f1 = Func[0] | Func[3];
assign Operation[0] = f1 & ALUOp[1];
assign f3 = Func[1] & ALUOp[1];
assign negAlu = ~ALUOp[1];
assign negOp = ~Func[2];
assign Operation[1] = negAlu | negOp;
assign Operation[2] = f3 | ALUOp[0];
endmodule

module tb;
wire [1:0] ALUOp; 
reg [5:0] Op;
wire [2:0] Operation;
reg [5:0] Func;

ALUOp_generate ag(ALUOp[0],ALUOp[1],Op);
aluControlLogic al(Func, ALUOp,Operation);

initial
$monitor(,$time,"ALUOp1=%b ALUOp2=%b Func=%b Operation=%b",ALUOp[0],ALUOp[1],Func,Operation);

initial
begin 
Op = 6'b000000; Func = 6'b000000;
#100 Op = 6'b101010;Func = 6'b001010;
#200 Op = 6'b010101;Func = 6'b000101;
#300 Op = 6'b010101;Func = 6'b000100;
#400 Op = 6'b110101;Func = 6'b000010;
#500 Op = 6'b111111;Func = 6'b000101;
#600 Op = 6'b010101;Func = 6'b001010;
#700 $finish;
end 
endmodule
