module comp(a,b,aeqb,agtb,altb);
input [3:0] a,b;
output aeqb,agtb,altb;
reg aeqb,agtb,altb;

always @(a or b)
begin
aeqb=0; agtb=0; altb=0;
if(a==b)
aeqb=1;
else if (a>b)

agtb=1;
else
altb=1;
end
end module

module testbench;
reg [3:0]a,b;
wire f1, f2, f3;

comp c(a,b,f1,f2,f3);

initial
begin

$monitor(,$time,"a=%4b b=%4b f1=%b f2=%b f3=%b",a,b,f1,f2,f3);

#0 a = 4'b0000;
#0 b = 4'b0001;

repeat(8)

#5 a = a+4'b0101;
#5 b = b+4'b1000;
end

initial
begin
$dumpfile("4bitmagnitude.vcd");
$dumpvars();
end

endmodule