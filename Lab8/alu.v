module alu(ctrl,A,B,X,cout);
input [2:0] ctrl;
input [3:0] A,B;
output [3:0] X;
reg [3:0] X;
output cout;
reg cout;
always@(*)
begin

if(ctrl==3'b000)
    {cout,X}=A+B;
else if(ctrl==3'b001)
    {cout,X}= A-B;
else if(ctrl==3'b010)
    X = A ^ B;
else if(ctrl==3'b011)
    X = A | B;
else if(ctrl==3'b100)
    X = A & B;
else if(ctrl==3'b101)
    X = A ~| B;
else if(ctrl==3'b110)
    X = A ~& B;
else if(ctrl==3'b111)
    X = A ^~B;
    
end
endmodule

module tb2;
reg [3:0] A,B;
reg [2:0] ctrl;
wire [3:0] X;
wire cout;

alu al(ctrl,A,B,X,cout);

initial begin
$monitor(,$time,"A=%b B=%b ctrl=%b X=%b",A,B,ctrl,X);
#0 A = 4'd8; B=4'd1; ctrl=3'b000;
#5 A = 4'd2; B=4'd3; ctrl=3'b010;
#10 A = 4'd4; B=4'd5; ctrl=3'b011;
end

endmodule
