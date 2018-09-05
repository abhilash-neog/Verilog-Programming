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
reg [2:0]a; /*using loop*/
wire f; 
mux2to1_gate mux_gate (a[0],a[1],a[2],f); 
initial
begin
$dumpfile("test.vcd");
$dumpvars();
	$monitor(,$time," a=%b, b=%b, s=%b f=%b",a[0],a[1],a[2],f);
	#0 a =  3'b000;
	repeat(8)/*repeat the loop 8 times*/
	#8 a = a + 3'b001;/*after every 8s change the value of a, which in turn changes the value of a[0,1,2]. It runs for 8*8 = 64s */
	end
endmodule
/* a[2:0] multi(3) bit input; begin #0 a = 3'b000; repeat(8); #8 a=a+3'b000*/
/* iverilog -o first first.v -> first is the name of the executable; vvp first*/