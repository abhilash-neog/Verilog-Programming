module fadder_behav(a,b,cin,s,cout);
input [3:0] a, b;
input cin;
output reg temp;
output reg [3:0] s;
output reg cout;
reg temp1,temp2;
integer i;
initial
temp = cin;
always@(a or b)

for(i=0;i<=3;i=i+1)
begin
temp1 = a[i] ^ b[i];
s[i] = temp1 ^ cin;
temp2 = a[i]&b[i];
temp = temp2||(temp1 & temp);

if(i==3) 
begin
cout = cin;
end
end
endmodule

module testbench;
reg [3:0]a,b;
wire [3:0]s;
reg z;
wire c;
fadder_behav fb(a,b,z,s,c);

initial
begin
$dumpfile("fadderBehavioral.vcd");
$dumpvars();
end

initial
$monitor(,$time,"a=%4b,b=%4b,z=%b,s=%4b,c=%b",a,b,z,s,c);
initial        
begin        
    #0 x =  32'b00000000000000000000000000000000;//#0 represents delay
	#0 y =  32'b00000000000000000000000000000001;
	#0 z =  1'b0;
	repeat(8)/*repeat the loop 8 times*/
	#8 x = x + 32'b00000000000000000000000000000001;
	#8 y = y + 32'b00000000000000000000000000000011;
end 
endmodule



