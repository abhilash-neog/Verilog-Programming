module FA_dataflow (Cout, Sum,In1,In2,Cin);   
input [31:0]In1,In2;   
input Cin;   
output Cout;   
output [31:0]Sum;     
assign {Cout,Sum}=In1+In2+Cin; 
endmodule

module tb;
reg [31:0]in1,in2;
reg cin;
wire cout;
wire [31:0]sum;
FA_dataflow f1(cout,sum,in1,in2,cin);

initial
begin
$monitor(,$time,"in1 = %b  in2=%b out=%b cin=%b cout = %b",in1,in2,sum,cin,cout);
#0  in1 = 32'd1;//decimal 1
	in2 = 32'd3;
	cin = 1'b0;
#10 in1 = in1+32'd9;
	in2 = in2+32'd9;
#10 in1= in1+32'd2;
	in2= in2+32'd2;
end

endmodule