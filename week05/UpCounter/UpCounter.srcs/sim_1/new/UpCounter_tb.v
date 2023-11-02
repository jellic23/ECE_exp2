`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:32:22
// Design Name: 
// Module Name: UpCounter_tb
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


module UpCounter_tb();
reg clk,rst;
wire [1:0] state;
Upcounter u0(clk,rst,state);

initial begin
    clk<=0; rst<=0;
    #5 rst<=1;
end

always begin
    #5 clk <= ~clk;
end

endmodule
