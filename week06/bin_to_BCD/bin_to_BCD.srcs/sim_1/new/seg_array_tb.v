`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 17:40:44
// Design Name: 
// Module Name: seg_array_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg_array_tb( );
reg clk, rst, btn;
wire [7:0] seg_data; 
wire [7:0] seg_sel;

seg_array Seg1(clk, rst, btn, seg_data[7:0],seg_sel[7:0]);

initial begin
    clk<=0; rst <=0; btn<=0;
    #10 rst<=1;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    #200 btn<=1;     #200 btn<=0;
    
end

always begin
    #5 clk <= ~clk;
end

endmodule
