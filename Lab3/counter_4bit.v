'include jkFlipFlop.v

module counter(clk,Q);
wire [3:0] Q;
wire [3:0] Q';

jk j1(Q[0],Q'[0],1'b1,1'b1,clk);
jk j2(Q[1],Q'[1],Q[0],Q[0],clk);
jk j3(Q[2],Q'[2],Q[0]&Q[1],Q[0]&Q[1],clk);
jk j4(Q[3],Q'[3],Q[0]&Q[1]&Q[2],Q[0]&Q[1]&Q[2],clk);

endmodule

