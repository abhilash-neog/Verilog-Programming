module fadder_behav(a,b,cin,s,cout);
input [3:0] a, b;
input cin;
output [3:0] s;
output cout;

always@(a or b)
begin
{cout,s} = a+b+cin;
end

endmodule

