module bit32OR (out,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
assign {out}= in1 | in2;
endmodule

module tb32bitor;
reg [31:0] IN1,IN2;
wire [31:0] OUT;
bit32OR a1 (OUT,IN1,IN2);

initial 
begin
$monitor(,$time,"inp1 = %b inp2 = %b out=%b", IN1,IN2,OUT);
end
initial
begin
IN1=4'd10;
IN2=4'd8;
#100 IN1=4'd12;
#400 $finish;
end
endmodule