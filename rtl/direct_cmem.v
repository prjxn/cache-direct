module direct_cmem(clk,rst,addr,rd,wr,r_data,w_data,hit,miss);

input clk,rst,rd,wr;
input [5:0] addr;
input [7:0] w_data;

output hit,miss;
output [7:0] r_data;

wire [7:0] rm_data, rc_data;
wire [2:0] cache_addr, tag_data;

assign cache_addr = addr[2:0];
assign  tag_data  = addr[5:3];

tag_mem t1(.addr(cache_addr),.data(tag_data),.en(rd),.hit(hit),.miss(miss),.clk(clk),.rst(rst));
main_mem m1(.addr(addr),.rd(rd),.wr(wr),.w_data(w_data),.r_data(rm_data),.clk(clk),.rst(rst));
cache_mem c1(.addr(cache_addr),.rd(rd),.wr(miss),.w_data(rm_data),.r_data(rc_data),.clk(clk),.rst(rst));

assign r_data = hit ? rc_data : rm_data;

endmodule
