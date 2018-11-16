module shifter(in,out);
input [31:0] in;
output [31:0] out;
//reg [31:0] out;
//initial
assign out = {in[29:0],2'b00};

endmodule

module tb;

reg [31:0] tx;
wire [31:0] ty;

shifter sft(tx,ty);

initial 
begin
$monitor(,$time,"tx=%b ty=%b",tx,ty);
#0 tx = 32'hffff;
#10 tx=  32'hf0f0;
#10 tx = 32'hafaf;
end
endmodule