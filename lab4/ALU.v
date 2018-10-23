module mux4to1(out,sel,in1,in2,in3);   
input in1,in2,in3,in4;
input [1:0] sel;
output out;   
wire ns1,ns2;  
not (ns1,sel[0]); 
not (ns2,sel[1]);
and(t1,ns1,ns2,in1);
and(t2,sel[0],ns2,in2);
and(t2,ns1,sel[1],in3);
//and(t3,sel[0],sel[1],in4);
//build a 4to1 using 2to1
or(out,t1,t2,t3); 
endmodule


module bit8_4to1mux(out,sel,in1,in2,in3);   
input [7:0] in1,in2,in3;   
output [7:0] out;   
input [1:0] sel;   
genvar j;  //this is the variable that is be used in the generate //block. Don't use integer;   
generate  for (j=0; j<8;j=j+1) begin: mux_loop  
//mux_loop is the name of the loop   
mux4to1 m1(out[j],sel,in1[j],in2[j],in3[j]);   
//mux2to1 is instantiated every time it is called . generate can't be written inside an always block

end 
endgenerate 
endmodule

module bit32_4to1mux(out,sel,in1,in2,in3);
input [31:0] in1,in2,in3;
output [31:0] out;
input [1:0] sel;

bit8_4to1mux b2(out[7:0],sel,in1[7:0],in2[7:0],in3[7:0]);
bit8_4to1mux b5(out[15:8],sel,in1[15:8],in2[15:8],in3[15:8]);
bit8_4to1mux b3(out[23:16],sel,in1[23:16],in2[23:16],in3[23:16]);
bit8_4to1mux b4(out[31:24],sel,in1[31:24],in2[31:24],in3[31:24]);
endmodule

module bit32AND (out,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
assign {out}=in1 &in2;
endmodule

module bit32OR (out,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
assign {out}=in1 | in2;
endmodule

module FA_dataflow (Cout, Sum,In1,In2,Cin);   
input [31:0]In1,In2;   
input Cin;   
output Cout;   
output [31:0]Sum;     
assign {Cout,Sum}=In1+In2+Cin; 
endmodule

module mux2to1(out,sel,in1,in2);   
input in1,in2,sel;   
output out;   
wire not_sel,a1,a2;   
not (not_sel,sel);   
and (a1,sel,in2);   
and (a2,not_sel,in1);   
or(out,a1,a2); 
endmodule


module bit8_2to1mux(out,sel,in1,in2);   
input [7:0] in1,in2;   
output [7:0] out;   
input sel;   
genvar j;  //this is the variable that is be used in the generate //block. Don't use integer;   
generate  for (j=0; j<8;j=j+1) begin: mux_loop  
//mux_loop is the name of the loop   
mux2to1 m1(out[j],sel,in1[j],in2[j]);   
//mux2to1 is instantiated every time it is called . generate can't be written inside an always block
end 
endgenerate 
endmodule

module bit32_2to1mux(out,sel,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
input sel;
genvar j;
generate for(j=0;j<24;j=j+8) begin:mloop
bit8_2to1mux b1(out[j+7:j],sel,in1[j+7:j],in2[j+7:j]);
end
endgenerate
endmodule

module ALU(a,b,Binvert,Carryin,Operation,Result,CarryOut);
input [31:0]a,b;
input Binvert,Carryin;
input [1:0]Operation;
output [31:0] Result;
output CarryOut;
wire [31:0] nb;
genvar i;
generate for(i=0;i<32;i=i+1) begin:not_loop
not n1(nb[i],b[i]);
end
endgenerate
wire [31:0] out2to1;
wire [31:0] sum;
wire [31:0] outand;
wire [31:0] outor;

bit32_2to1mux m1(out2to1,Binvert,b,nb);
FA_dataflow fl(CarryOut,sum,a,out2to1,Carryin);

bit32AND and1(outand,a,out2to1);
bit32OR or1(outor,a,out2to1);

bit32_4to1mux res(Result,Operation,outand,outor,sum);
endmodule


module tbALU;
reg Binvert, Carryin;
reg [1:0] Operation;
reg [31:0] a,b;
wire [31:0] Result;
wire CarryOut;
ALU al(a,b,Binvert,Carryin,Operation,Result,CarryOut);
initial
begin
$monitor(,$time,"a1 = %32b b1=%32b Binv=%b Op=%8b res=%b cout=%b",a,b,Binvert,Carryin,Operation,Result,CarryOut);
end
initial
begin
a=32'ha5a5a5a5;
b=32'h5a5a5a5a;
Operation=2'b00;
Binvert=1'b0;
Carryin=1'b0; //must perform AND resulting in zero
#100 Operation=2'b01; //OR
#100 Operation=2'b10; //ADD
#100 Binvert=1'b1;//SUB
#200 $finish;
end
endmodule