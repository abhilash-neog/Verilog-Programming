module mux4to1(out,sel1,sel2,in1,in2,in3,in4);   
input in1,in2,in3,in4,sel1,sel2;   
output out;   
wire ns1,ns2;  
not (ns1,sel1); 
not (ns2,sel2);
and(t1,ns1,ns2,in1);
and(t2,sel1,ns2,in2);
and(t2,ns1,sel2,in3);
and(t3,sel1,sel2,in4);
//build a 4to1 using 2to1
or(out,t1,t2,t3,t4); 
endmodule


module bit8_2to1mux(out,sel1,sel2,in1,in2,in3,in4);   
input [7:0] in1,in2,in3,in4;   
output [7:0] out;   
input sel1,sel2;   
genvar j;  //this is the variable that is be used in the generate //block. Don't use integer;   
generate  for (j=0; j<8;j=j+1) begin: mux_loop  
//mux_loop is the name of the loop   
mux4to1 m1(out[j],sel1, sel2,in1[j],in2[j],in3[j],in4[j]);   
//mux2to1 is instantiated every time it is called . generate can't be written inside an always block

end 
endgenerate 
endmodule

module bit32_2to1mux(out,sel1,sel2,in1,in2,in3,in4);
input [31:0] in1,in2,in3,in4;
output [31:0] out;
input sel1,sel2;
//genvar j;
//generate for(j=0;j<24;j=j+8) begin:mloop
//bit8_2to1mux b1(out[j+7:j],sel1,sel2,in1[j+7:j],in2[j+7:j],in3[j+7:j],in4[j+7:j]);
bit8_2to1mux b2(out[7:0],sel1,sel2,in1[7:0],in2[7:0],in3[7:0],in4[7:0]);
bit8_2to1mux b5(out[15:8],sel1,sel2,in1[15:8],in2[15:8],in3[15:8],in4[15:8]);
bit8_2to1mux b3(out[23:16],sel1,sel2,in1[23:16],in2[23:16],in3[23:16],in4[23:16]);
bit8_2to1mux b4(out[31:24],sel1,sel2,in1[31:24],in2[31:24],in3[31:24],in4[31:24]);
//end
//endgenerate
endmodule

module testbench;   
reg [31:0] INP1, INP2, INP3, INP4;   
reg SEL1,SEL2;   
wire [31:0] out;   
bit32_2to1mux M1(out,SEL1,SEL2,INP1,INP2,INP3,INP4);   
initial
begin
$monitor(,$time,"in1 = %32b  in2=%32b in3 = %32b  in4=%32b out=%32b sel1=%b sel2 = %b",INP1,INP2,INP3,INP4,out,SEL1,SEL2);
end   
initial
begin     
INP1=32'b10101010101010101010101010101010;     
INP2=32'b01010101010101010101010101010101;
INP3=32'b00000000000000000001001001000000;
INP4=32'b00000000000000000000000000000000;     
SEL1=1'b0;
SEL2=1'b1;     
#100 SEL1=1'b1;SEL2=1'b0;
#100 SEL1=1'b1;SEL2=1'b1;
#100 SEL1=1'b0;SEL2=1'b0;    
#1000 $finish;   
end 
endmodule 
