module mux4to1(out,sel,in1,in2,in3);   
input in1,in2,in3;//,in4;
input [1:0] sel;
output out;   
wire ns1,ns2;  
not (ns1,sel[0]); 
not (ns2,sel[1]);
and(t1,ns1,ns2,in1);
and(t2,sel[0],ns2,in2);
and(t3,ns1,sel[1],in3);
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
genvar j;
generate  for (j=0; j<32;j=j+1) begin: mux_loop 
mux4to1 b2(out[j],sel,in1[j],in2[j],in3[j]);
end
endgenerate
endmodule

/*
module bit32_4to1mux(out,sel,in1,in2,in3);
input [31:0] in1,in2,in3;
output [31:0] out;
input [1:0] sel;
bit8_4to1mux b2(out[7:0],sel,in1[7:0],in2[7:0],in3[7:0]);
bit8_4to1mux b5(out[15:8],sel,in1[15:8],in2[15:8],in3[15:8]);
bit8_4to1mux b3(out[23:16],sel,in1[23:16],in2[23:16],in3[23:16]);
bit8_4to1mux b4(out[31:24],sel,in1[31:24],in2[31:24],in3[31:24]);
endmodule*/


module testbench;   
reg [31:0] INP1, INP2, INP3;   
reg [1:0] SEL;   
wire [31:0] out;   
bit32_4to1mux M1(out,SEL,INP1,INP2,INP3);   
initial
begin
$monitor(,$time,"in1 = %32b  in2=%32b in3 = %32b out=%32b sel1=%b sel2 = %b",INP1,INP2,INP3,out,SEL[0],SEL[1]);
end   
initial
begin     
INP1=32'b10101010101010101010101010101010;     
INP2=32'b01010101010101010101010101010101;
INP3=32'b00000000000000000001001001000000;
//INP4=32'b00000000000000000000000000000000;     
SEL[0]=1'b0;
SEL[1]=1'b1;     
#100 SEL[0]=1'b1;SEL[1]=1'b0;
#100 SEL[0]=1'b1;SEL[1]=1'b1;
#100 SEL[0]=1'b0;SEL[1]=1'b0;    
#1000 $finish;   
end 
endmodule 
