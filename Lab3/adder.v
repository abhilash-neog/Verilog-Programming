module fadder_behav(a,b,cin,sum,cout);
input [3:0]a,b;
input cin;
output [3:0]sum;
output cout;
reg sum;//need to define a reg for lvalue, sum and cout.else error
reg cout;

always@(*) begin

{cout,sum}=a+b+cin;

end
endmodule


module testbench;
reg [3:0]a,b;
wire [3:0]s;//reg s cannot be driven by continuous assign.
reg z;
wire c;
fadder_behav fb(a,b,z,s,c);

initial
begin
$dumpfile("fadderBehavioral.vcd");
$dumpvars();
end

initial
$monitor(,$time ,"a=%4b,b=%4b,z=%b,s=%4b,c=%b",a,b,z,s,c);
initial        
begin        
    #0 a =  4'b0001;// represents delay
	#0 b =  4'b0010;
	#0 z =  1'b0;
	repeat(8)//repeat the loop 8 times
	#8 a = a + 4'b0001;
	#8 b = b + 4'b0100;
end 
endmodule



