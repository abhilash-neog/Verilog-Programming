module paritygenerator(inp,out);
input [3:0] inp;
output out;
assign out = (inp[0]^inp[1]^inp[2]^inp[3]);
endmodule

