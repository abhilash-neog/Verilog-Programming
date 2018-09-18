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

