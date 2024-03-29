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
