`timescale 1ns/1ps
module encoder(inp,out);
input [7:0] inp;
output [2:0] out;
reg [2:0] out;
always@(inp)
begin
case(inp)
    8'b10000000:out=3'b000;
    8'b01000000:out=3'b001;
    8'b00100000:out=3'b010;    
    8'b00010000:out=3'b011;
    8'b00001000:out=3'b100;
    8'b00000100:out=3'b101;
    8'b00000010:out=3'b110;
    8'b00000001:out=3'b111;
    default :out=3'bz;
    endcase 
end 
endmodule

module tb1;
reg [7:0] in;
wire [2:0] out;

encoder enc(in,out);

initial begin
$monitor(,$time,"inp=%b out=%b",in,out);
#0 in = 8'd8;
#5 in = 8'd1;
end

endmodule