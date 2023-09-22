`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 13:31:10
// Design Name: 
// Module Name: Dflipflop_tb
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


module Dflipflop_tb();
reg clk,D;
wire Q;
Dflipflop DFF(clk,D,Q);

initial begin
    D=0; clk<=0;
    #20 D<=0;
    #20 D<=1;
    #20 D<=0;
    #20 D<=1;
    #20 D<=0;
    #20 D<=1;
    #20 D<=0;
end

always begin
    #5 clk <= ~clk;
end

endmodule
