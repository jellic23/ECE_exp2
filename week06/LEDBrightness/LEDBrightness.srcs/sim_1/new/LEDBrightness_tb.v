`timescale 1us / 1ns


module LEDBrightness_tb();

reg clk, rst;
reg [7:0] bin;
wire [7:0] seg_data;
wire [7:0] seg_sel;
wire led_signal;

LEDBrightness LEDB1(clk, rst, bin[7:0], seg_data[7:0], seg_sel[7:0], led_signal);

initial begin
    clk<=0; rst<=1; bin <= 8'b00000000; 
    #10 rst <=0;
    #5120 bin <= 8'b01000000;
    #5120 bin <= 8'b10000000;
    #5120 bin <= 8'b11000000;
    #5120 bin <= 8'b11111111;
    #5120 bin <= 8'b00000000;
    
    
end

always begin
    #0.5 clk <= ~clk;
end

endmodule
