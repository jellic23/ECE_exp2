`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 18:49:45
// Design Name: 
// Module Name: Tflipflop
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


module Tflipflop(clk, rst, T, Q);
input clk, rst, T;
output reg Q;
reg T_reg, T_trig;

always @(posedge clk or negedge rst) begin
    if(rst) begin
        T_reg <= T;
        T_trig <= T & ~T_reg;
    end
    else begin
        Q <= 1'b0;
        T_reg <= 1'b0;
        T_trig <= 1'b0;
    end
    
    if(T_trig) begin
        Q <=~Q;
    end
    
end


endmodule
