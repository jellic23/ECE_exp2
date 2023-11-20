`timescale 1ns / 1ps

module LCD_cursor_tb( );
reg rst, clk;
reg [9:0] number_btn;
reg [9:0] control_btn;

wire LCD_E, LCD_RS, LCD_RW;
wire [7:0] LCD_DATA;
wire [7:0]  LED_out;


LCD_cursor LCD_C1(rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA[7:0], LED_out[7:0], number_btn[9:0], control_btn[9:0]);


initial begin
rst <= 0; clk <= 0;
number_btn[9:0] <= 10'b0000_0000_00; control_btn[9:0] <= 10'b0000_0000_00;
#5 rst <=1;
#300 number_btn[9:0] <= 10'b0000_0000_10; //number 9 button
#300 number_btn[9:0] <= 10'b0100_0000_00; //number 2 button
#300 control_btn[1:0] <= 2'b10; //left button
#300 control_btn[1:0] <= 2'b01; //right button 

end


always begin
    #0.5 clk <= ~clk;
end


endmodule
