module cache_mem(addr,wr,rd,w_data,r_data,clk,rst);
input clk,rst,wr,rd;
input [2:0] addr;
input [7:0] w_data;
output reg [7:0] r_data;

reg [7:0] mem [0:7];
integer i;

always@(negedge clk) if (wr && ~rst) mem[addr] <= w_data ;

always@(posedge clk or posedge rst) begin 
if(rst)	begin
	for (i=0;i<8;i=i+1) mem[i] <= 8'b0;
	r_data <= 8'b0;
end
else begin
	if (rd) r_data <= mem[addr];
end end
endmodule
