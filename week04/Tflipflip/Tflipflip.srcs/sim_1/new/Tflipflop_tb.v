`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 18:53:14
// Design Name: 
// Module Name: Tflipflop_tb
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


module Tflipflop_tb();
reg clk,rst,T;
wire Q;
Tflipflop TFF(clk,rst,T,Q);

initial begin
clk <= 0; rst <= 0;
#20 rst <= 1;
#80 T <= 0;
#80 T <= 1;
#80 T <= 0;
#80 T <= 1;
#80 T <= 0;
#80 T <= 1;
#80 T <= 0;
#80 T <= 1;
#80 T <= 0;
end
always begin
    #5 clk <= ~clk;
 end

endmodule
