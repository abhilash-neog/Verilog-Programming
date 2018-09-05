module mux2to1_gate(a,b,c,d);
 input a, b, c;
 output d;
 wire l,m,n;
 
 not e1(l,c);
 and a1(m,l,a);
 and a2(n,c,b);
 or o1(f,m,n);
endmodule

module testbench; 
reg a,b,s; 
wire f; 
mux2to1_gate mux_gate (a,b,s,f); 
initial
begin
$dumpfile("test.vcd");
$dumpvars();
	$monitor(,$time," a=%b, b=%b, s=%b f=%b",a,b,s,f);
	#0 a=1'b0;b=1'b1; /* #0, #2, these are all different time instances where the variables are changed*/
	#2 s=1'b1; /* 1 bit variable with value 0*/
	#5 s=1'b0; 
	#10 a=1'b1;b=1'b0; 
	#15 s=1'b1; 
	#20 s=1'b0; 
	#100 $finish;
	end
endmodule
/* a[2:0] multi(3) bit input; begin #0 a = 3'b000; repeat(8); #8 a=a+3'b000*/
/* iverilog -o first first.v -> first is the name of the executable; vvp first*/