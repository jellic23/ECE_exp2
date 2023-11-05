`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 20:16:06
// Design Name: 
// Module Name: piezo_tb
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


module piezo_tb();

reg clk, rst;
reg [7:0] btn; 
wire piezo;

piezo_basic Pie2(clk, rst, btn, piezo);

initial begin
    clk <= 0; rst <= 0;
    btn <= 8'b00000000;
    #1e+6; rst <= 0;
    #1e+6; rst <= 1;
    #1e+6; btn <= 8'b00000001;
    #1e+6; btn <= 8'b00000010;
    #1e+6; btn <= 8'b00000100;
    #1e+6; btn <= 8'b00001000;
    #1e+6; btn <= 8'b00010000;
    #1e+6; btn <= 8'b00100000;
    #1e+6; btn <= 8'b01000000;
    #1e+6; btn <= 8'b10000000;
end

always begin
    #0.5 clk <= ~clk;
end

endmodule
