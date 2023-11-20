`timescale 1us / 1ns

module clock_main_tb();
reg clk, rst;
reg [3:0] btn;
wire [17:0] ticking;
wire [7:0] seg_data;
wire [7:0] seg_sel;

clock_main Clock1(clk, rst, btn[3:0], ticking[17:0], seg_data[7:0], seg_sel[7:0]);

initial begin
    clk <= 0; rst <=0;
    #1 rst<=1;
end


always begin
    #0.5 clk <= ~clk;
end

endmodule
