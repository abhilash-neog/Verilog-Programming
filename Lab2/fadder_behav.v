module fadder_behav(a,b,cin,s,cout);
input [3:0] a, b;
input cin;
output [3:0] s;
output cout;
reg temp1,temp2;
integer i;

always@(a or b)

for(i=0;i<=3;i=i+1)
begin
temp1 = a[i] ^ b[i];
s[i] = temp1 ^ cin;

temp2 = a[i]&b[i];
cin = temp2||(temp1 & cin);

if(i==3) cout = cin;

end
endmodule

