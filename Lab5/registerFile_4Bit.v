module mux1bit(out,sel,in1,in2,in3,in4);   
input in1,in2,in3,in4;
input [1:0] sel;
output out;   
wire ns1,ns2;  
not (ns1,sel[0]); 
not (ns2,sel[1]);
and(t1,ns1,ns2,in1);
and(t2,sel[0],ns2,in2);
and(t3,ns1,sel[1],in3);
and(t4,sel[0],sel[1],in4);
or(out,t1,t2,t3,t4); 
endmodule


module mux4_1(regData,q1,q2,q3,q4,reg_no);
input [31:0] q1,q2,q3,q4;
output [31:0] regData;
input [1:0] reg_no;
genvar j;
generate  for (j=0; j<32;j=j+1) begin: mux_loop 
mux1bit b2(regData[j],reg_no,q1[j],q2[j],q3[j],q4[j]);
end
endgenerate
endmodule

module decoder2_4(register,reg_no);

input [1:0]reg_no; 
output [3:0]register; 
wire x0,y0; 
not n1(x0,reg_no[0]); 
not n2(y0,reg_no[1]);

and a0(register[0],y0,x0); 
and a1(register[1],y0,reg_no[0]); 
and a2(register[2],reg_no[1],x0); 
and a3(register[3],reg_no[0],reg_no[1]);

endmodule

module d_ff(q,d,clk,reset);
output [3:0] q; // output data
input [3:0] d; // input data
input clk,reset;
reg [3:0] q;
always @(posedge clk or negedge reset)
begin
if (reset)
q=d;
else
q=4'b0000;
end
endmodule

module reg_32bit(q,d,clk,reset);
 output [31:0]q; // output data
 input [31:0]d; // input data
 input clk,reset; // clock and clear
 genvar j; 
 generate  for (j=0; j<32;j=j+4) begin: mux_loop
 d_ff df(q[j+3:j],d[j+3:j],clk,reset); 
 end
 endgenerate
endmodule

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);

input clk,reset,RegWrite;
input [1:0] ReadReg1,ReadReg2,WriteReg;
input [31:0] WriteData;
output [31:0] ReadData1,ReadData2;
wire [3:0]rg;
decoder2_4 dc(rg,WriteReg);
wire w0,w1,w2,w3;

and a1(w0,rg[0],clk,RegWrite);
and a2(w1,rg[1],clk,RegWrite);
and a3(w2,rg[2],clk,RegWrite);
and a4(w3,rg[3],clk,RegWrite);

wire [31:0] regdata1,regdata2,regdata3,regdata4;

reg_32bit rb0(regdata1,WriteData,w0,reset);
reg_32bit rb1(regdata2,WriteData,w1,reset);
reg_32bit rb2(regdata3,WriteData,w2,reset);
reg_32bit rb3(regdata4,WriteData,w3,reset);

mux4_1 m1(ReadData1,regdata1,regdata2,regdata3,regdata4,ReadReg1);
mux4_1 m2(ReadData2,regdata1,regdata2,regdata3,regdata4,ReadReg2);

endmodule;

