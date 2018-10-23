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
genvar j;  
generate  for (j=0; j<8;j=j+1) begin: mux_loop  
//mux_loop is the name of the loop   
mux2to1 m1(out[j],sel,in1[j],in2[j]);   
end 
endgenerate 
endmodule

module bit32_2to1mux(out,sel,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
input sel;
genvar j;
generate for(j=0;j<32;j=j+1) begin:mloop
mux2to1 b1(out[j],sel,in1[j],in2[j]);
end
endgenerate
endmodule

/*
module bit32_2to1mux(out,sel,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
input sel;
genvar j;
generate for(j=0;j<24;j=j+8) begin:mloop
bit8_2to1mux b1(out[j+7:j],sel,in1[j+7:j],in2[j+7:j]);
end
endgenerate
endmodule*/

module testbench;   
reg [31:0] INP1, INP2;   
reg SEL;   
wire [31:0] out;   
bit32_2to1mux M1(out,SEL,INP1,INP2);   
initial
begin
$monitor(,$time,"in1 = %32b  in2=%32b  out=%32b \n sel=%b",INP1,INP2,out,SEL);
end   
initial
begin     
INP1=32'b10101010101010101010101010101010;     
INP2=32'b01010101010101010101010101010101;     
SEL=1'b0;     
#100 SEL=1'b1;     
#1000 $finish;   
end 
endmodule 
