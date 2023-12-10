`timescale 1us / 1ns

module clock_main_tb();
reg clk, rst;
reg [3:0] btn;
reg emergency_btn;
reg  addhour_btn;
wire [7:0] seg_data;
wire [7:0] seg_sel;
wire [3:0] south;
wire [3:0] north;
wire [3:0] west;
wire [3:0] east;
wire [1:0] south_p;
wire [1:0] north_p;
wire [1:0] west_p;
wire [1:0] east_p;
wire LCD_E;
wire LCD_RS;
wire LCD_RW;
wire [7:0] LCD_DATA;

clock_main Clock1(clk, rst, btn[3:0], emergency_btn, addhour_btn, seg_data[7:0], seg_sel[7:0], south[3:0], north[3:0], west[3:0], east[3:0], south_p[1:0], north_p[1:0], west_p[1:0], east_p[1:0], LCD_E, LCD_RS, LCD_RW, LCD_DATA[7:0]);

initial begin
    clk <= 0; rst <=0; btn <= 0; emergency_btn <=0; addhour_btn<=0;
    #1 rst<=1;
    #1 btn[0]<=1;
    #7500 addhour_btn<=1;
    #502950 emergency_btn <=1;#5 emergency_btn <=0;
    
end


always begin
    #0.5 clk <= ~clk;
end

endmodule
