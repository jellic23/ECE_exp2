`timescale 1us / 1ns

module text_LCD_basic_tb();

reg rst, clk;

wire LCD_E,LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0]  LCD_out;

text_LCD_basic tLb01(rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA[7:0], LCD_out[7:0]);

initial begin
    rst <= 0; clk <= 0; 
    #4 rst <= 1;
end

always begin
    #0.5 clk <= ~clk;
end



endmodule
