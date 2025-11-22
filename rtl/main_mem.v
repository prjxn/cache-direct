module main_mem(addr,wr,rd,w_data,r_data,clk,rst);
input rst,clk,wr,rd;
input [5:0] addr;
input [7:0] w_data;
output reg [7:0] r_data;

reg [7:0] mem [0:63];
integer i;

always@(posedge clk or posedge rst) begin 
if(rst) begin
	for (i=0;i<64;i=i+1) mem[i] <= 8'b0;
	r_data <= 8'b0;
end
else begin
	if (wr) mem[addr] <= w_data;
	if (rd) r_data <= mem[addr];
end end
endmodule
