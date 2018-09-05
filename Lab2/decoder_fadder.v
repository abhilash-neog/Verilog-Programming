module decoder(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
input x,y,z; 
output d0,d1,d2,d3,d4,d5,d6,d7; 
wire x0,y0,z0; 
not n1(x0,x); 
not n2(y0,y); 
not n3(z0,z); 
and a0(d0,x0,y0,z0); 
and a1(d1,x0,y0,z); 
and a2(d2,x0,y,z0); 
and a3(d3,x0,y,z); 
and a4(d4,x,y0,z0); 
and a5(d5,x,y0,z); 
and a6(d6,x,y,z0); 
and a7(d7,x,y,z); 
endmodule

module fadder(s,c,x,y,z);
input x,y,z;
output s,c;
wire d0,d1,d2,d3,d4,d5,d6,d7; 

decoder ded(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);

assign s = d1|d2|d4|d7;
assign c = d3|d5|d6|d7;

endmodule

module adder(s,cx,x,y,z); 
input [7:0] x,y;
input z;
output [7:0] s;
output cx;
//wire cout;
fadder df(s[0],c, x[0],y[0],z);
fadder df1(s[1],c1, x[1],y[1],c);
fadder df2(s[2],c2, x[2],y[2],c1);
fadder df3(s[3],c3, x[3],y[3],c2);
fadder df4(s[4],c4, x[4],y[4],c3);
fadder df5(s[5],c5, x[5],y[5],c4);
fadder df6(s[6],c6, x[6],y[6],c5);
fadder df7(s[7],cx, x[7],y[7],c6);

//assign cx = s[8];
   
endmodule

module testbench;     
reg [7:0] x,y;
reg z;     
wire [7:0]s;
wire c;     
adder ad(s,c,x,y,z);  
initial
begin
$dumpfile("8bit.vcd");
$dumpvars();
end   
initial        
$monitor(,$time,"x=%8b,y=%8b,z=%b,s=%8b,c=%b",x,y,z,s,c);     
initial        
begin        
    #0 x =  8'b00000000;
	#0 y =  8'b00000001;
	#0 z =  1'b0;
	repeat(8)/*repeat the loop 8 times*/
	#8 x = x + 8'b00000001;
	#8 y = y + 8'b00000011;
end 
endmodule 