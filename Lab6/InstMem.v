module PC(count, clock, reset);
  input		clock, reset;
  output	[31:0]	count;
  reg	[31:0]	count;
  always @(posedge clock)
    if(!reset)
      count = count + 1;
    else
      count = 0;
endmodule



module Instruction_Memory(Inst, PC, clock);
	input[31:0] PC;
	input clock;
	output[31:0] Inst;
	reg [31:0] memory [31:0];
	reg [31:0] Inst;
  integer addr;
  initial begin
    memory[0] = 32'b00000000000000000000000000000000;  // nop
    memory[1] = 32'b00000000000000000000000000000000;  // nop
    memory[2] = 32'b00000000000000000000000000000000;  // nop
    memory[3] = 32'b10001100000100010000000000001000;  // lw  $s1($17), 8($0)
    memory[4] = 32'b10001100000100100000000000000100;  // lw  $s2($18), 4($0)
    memory[5] = 32'b00000010001100100100000000100000;  // add $t0($8), $s1($17), $s2($18)
    memory[6] = 32'b00000000000000000000000000000000;  // nop
    memory[7] = 32'b00000000000000000000000000000000;  // nop
    memory[8] = 32'b00000000000000000000000000000000;  // nop
    memory[9] = 32'b00000000000000000000000000000000;  // nop
    memory[10]= 32'b00000000000000000000000000000000;  // nop
    memory[11]= 32'b00000000000000000000000000000000;  // nop
    memory[12]= 32'b00000000000000000000000000000000;  // nop
    memory[13]= 32'b00000000000000000000000000000000;  // nop
    memory[14]= 32'b00000000000000000000000000000000;  // nop
    memory[15]= 32'b00000000000000000000000000000000;  // nop
    memory[16]= 32'b00000000000000000000000000000000;  // nop
    memory[17]= 32'b00000000000000000000000000000000;  // nop
    memory[18]= 32'b00000000000000000000000000000000;  // nop 
    memory[19]= 32'b00000000000000000000000000000000;  // nop
    memory[20]= 32'b00000000000000000000000000000000;  // nop
    memory[21]= 32'b00000000000000000000000000000000;  // nop
    memory[22]= 32'b00000000000000000000000000000000;  // nop
    memory[23]= 32'b00000000000000000000000000000000;  // nop
    memory[24]= 32'b00000000000000000000000000000000;  // nop
    memory[25]= 32'b00000000000000000000000000000000;  // nop
    memory[26]= 32'b00000000000000000000000000000000;  // nop
    memory[27]= 32'b00000000000000000000000000000000;  // nop
    memory[28]= 32'b00000000000000000000000000000000;  // nop 
    memory[29]= 32'b00000000000000000000000000000000;  // nop
    memory[30]= 32'b00000000000000000000000000000000;  // nop
    memory[31]= 32'b00000000000000000000000000000000;  // nop
  end
  always @(posedge clock) begin
    addr = PC;//[31:0];
    Inst = memory[addr/4];
	end
endmodule

module Tb;
  reg clock, reset;
  wire [31:0] count;
  wire [31:0] inst;
  PC pc(count, clock, reset);
  Instruction_Memory im(inst,count,clock);
  initial begin
    repeat(1000)
    # 5 clock = ~clock;
  end
  initial begin
    $monitor($time, " Reset = %b, Count= %b Instruction=%b", reset, count,inst);
    #0  clock = 1'b0; reset = 1'b1;
    #11  reset = 1'b0;
  end
endmodule