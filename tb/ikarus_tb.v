`timescale 1ns/1ps
module testbench_top;
reg clk;
reg rst, rd, wr;
reg [5:0] addr;
reg [7:0] w_data;
wire [7:0] r_data;
wire hit, miss;

direct_cmem DUT(
    .clk(clk),
    .addr(addr),
    .rd(rd),
    .wr(wr),
    .rst(rst),
    .r_data(r_data),
    .w_data(w_data),
    .hit(hit),
    .miss(miss)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("work/dump.vcd");
    $dumpvars(0, testbench_top);
end

initial begin
    $display(" Time(ns) | Addr | RD | WR | WDATA | RDATA | HIT | MISS");
    $monitor(" %8t | %4d |  %b |  %b |   %2h  |   %2h  |   %b |   %b",
	$time, addr, rd, wr, w_data, r_data, hit, miss);
    clk = 0; rst = 1; rd = 0; wr = 0;
    addr = 6'd0; w_data = 8'd0;
    #20 rst = 0; wr = 1; rd = 0; addr = 6'd5;   w_data = 8'hA5;
    #20 addr = 6'd15;  w_data = 8'h5A;
    #20 addr = 6'd25;  w_data = 8'h3C;
    #40 wr = 0; rd = 1; addr = 6'd5;
    #20 addr = 6'd15;
    #20 addr = 6'd25;
    #20 addr = 6'd5;
    #40 wr = 1; rd = 0; addr = 6'd25;   w_data = 8'hC3;
    #20 wr = 0; rd = 1; addr = 6'd25;
    #20 wr = 1; rd = 0; addr = 6'd9;   w_data = 8'hC3;
    #20 wr = 0; rd = 1; addr = 6'd9;
    #20 addr = 6'd25;
    #100 $display("Simulation finished successfully.");
    $finish;
end
endmodule
