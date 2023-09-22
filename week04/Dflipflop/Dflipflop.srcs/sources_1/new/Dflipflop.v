`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 12:42:34
// Design Name: 
// Module Name: Dflipflop
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
//set_property CLOCK_DEDICATED_ROUTEFALSE[get_nets clk_IBUF]

module Dflipflop(clk, D, Q);
input clk, D;
output reg Q;

always @(posedge clk) begin
Q<=D;
end

endmodule
