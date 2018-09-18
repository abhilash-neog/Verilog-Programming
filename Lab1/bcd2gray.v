module bcdgray(a[3:0],f[3:0]);
 input [3:0]a;
 output [3:0]f;
 assign f[3] = a[3];
 xor x1(f[2],a[3],a[2]);
 //assign f[1] = l;
 xor x2(f[1],a[2],a[1]);
 //assign f[2] = m;
 xor x3(f[0],a[1],a[0]);
 //assign f[3] = n;
endmodule

module testbench; 
reg [3:0]a; /*using loop*/
wire [3:0]f; 
bcdgray bcg (a[3:0],f[3:0]); 
initial
begin
	$monitor(,$time," a=%4b f=%4b",a,f);
	#0 a =  4'b0000;
	repeat(8)/*repeat the loop 8 times*/
	#8 a = a + 4'b0001;/*after every 8s change the value of a, which in turn changes the value of a[0,1,2]. It runs for 8*8 = 64s */
	end
initial
begin
$dumpfile("bcd2gray.vcd");
$dumpvars();
end//there can be multiple begin and ends
endmodule