`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 14:05:10
// Design Name: 
// Module Name: StateDiagram_tb
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


module StateDiagram_tb();
reg clk, rst, state, y;
reg x;
StateDiagram u0(clk,rst,x,y,state);

initial begin
clk<=0; rst<=0;
#10 rst <= 1;
#10 x<=1'b1;
/* #10 x<=0;
#10 x<=1;
#10 x<=1;
*/
end

always begin
    #5 clk <= ~clk;
end

endmodule
