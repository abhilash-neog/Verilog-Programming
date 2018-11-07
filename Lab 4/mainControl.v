module ANDarray (RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op); 
input [5:0] Op; 
output RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2;  
wire Rformat, lw,sw,beq;  
assign Rformat= (~Op[5])& (~Op[4])& (~Op[3])& (~Op[2])& (~Op[1])& (~Op[0]);
assign lw = (Op[5])& (~Op[4])& (~Op[3])& (~Op[2])& (Op[1])& (Op[0]);
assign sw = (Op[5])& (~Op[4])& (Op[3])& (~Op[2])& (Op[1])& (Op[0]);
assign beq = (~Op[5])& (~Op[4])& (~Op[3])& (Op[2])& (~Op[1])& (~Op[0]);
assign RegDst=Rformat;
assign ALUSrc = lw | sw;
assign MemRead = lw;
assign MemWrite = sw;
assign MemtoReg =  lw;
assign RegWrite = lw | Rformat;
assign Branch = beq;
assign ALUOp1 = Rformat;
assign ALUOp2 = beq;
endmodule

module tb;
wire RegDst,ALUSrc,MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2; 
reg [5:0] Op;

ANDarray a1(RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2,Op);

initial
$monitor(,$time,"Op=%b RegDst=%b ALUSrc=%b MemtoReg=%b RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUOp1=%b ALUOp2=%b",Op,RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2);

initial
begin 
Op = 6'b000000;
#100 Op = 6'b101010;
#200 Op = 6'b010101;
#300 $finish;
end 
endmodule
