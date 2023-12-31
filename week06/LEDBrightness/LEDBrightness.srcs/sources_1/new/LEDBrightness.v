`timescale 1us / 1ns

module LEDBrightness(clk, rst, bin, seg_data, seg_sel, led_signal);

input clk, rst;
input [7:0] bin;

wire [7:0] cnt;

output[7:0] seg_data;
output [7:0] seg_sel;
output reg led_signal;

counter8 cl(clk, rst, cnt);
seg7_controller sl(clk, rst, bin, seg_data, seg_sel);

always @(posedge clk or posedge rst) begin
    if(rst) led_signal <= 0;
    else begin
        if(cnt <= bin) led_signal <= 1;
        else if(cnt > bin) led_signal <= 0;
    end
end

endmodule
