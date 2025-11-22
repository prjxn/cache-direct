module tag_mem(clk,rst,en,addr,data,hit,miss);
input clk, rst, en;
input [2:0] addr, data;
output reg hit,miss;

reg [3:0] mem [0:7];
integer i;

always @(posedge clk or posedge rst) begin
if (rst) begin
	for (i = 0; i < 8; i = i + 1) mem[i] <= 4'b0000;
	hit <= 1'b0; miss <= 1'b0;
end
else begin
	hit <= 1'b0; miss <=1'b0;
	if (en) begin
	if (mem[addr][3] && mem[addr][2:0] == data) begin
	hit <= 1'b1; miss <= 1'b0;
	end
	else begin
        mem[addr] <= {1'b1, data}; hit <= 1'b0; miss <= 1'b1;
        end
end end end
endmodule
