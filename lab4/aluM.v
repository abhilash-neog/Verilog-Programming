module mux4_1(I0,I1,I2,I3,s2,s1,y,en) 
 input I0,I1,I2,I3,s2,s1,en;
 output y;
 assigny<=((~s2)&(~s1)&I0)| ((~s2)&(s1)&I1)|(s2&(~s1)&I2)|(s2&s1&I3);
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

module ALU(a,b,Binvert,Carryin,Operation,Result,CarryOut);
input a,b,Carryin;
output Result,CarryOut;
wire binvert;
wire m1;
wire binvert = ~b;
mux2to1 m1(m1,Binvert,a,binvert);//simply connect it the way as in the fig



module tbALU();
reg Binvert, Carryin; 
reg [1:0] Operation; 
reg [31:0] a,b; 
wire [31:0] Result; 
wire CarryOut; 
ALU (a,b,Binvert,Carryin,Operation,Result,CarryOut);  
initial begin 
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