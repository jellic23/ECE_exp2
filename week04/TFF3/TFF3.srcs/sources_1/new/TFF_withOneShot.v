`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 18:21:00
// Design Name: 
// Module Name: TFF_withOneShot
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


module TFF_withOneShot(clk,rst,T,Q);
input clk, rst, T;
output reg Q;
reg T_reg, T_trig;

always @(posedge clk) begin
    if(!rst) begin
        Q <= 1'b0;
        T_reg<= 1'b0;
        T_trig <= 1'b0;
    end
    else begin
    T_reg <= T;
    T_trig <= T & ~T_reg;
    end

if (T_reg) begin
    Q<=~Q;
    end
end

always @(negedge rst) begin
    if(!rst) begin
        Q <= 1'b0;
        T_reg<= 1'b0;
        T_trig <= 1'b0;
    end
    else begin
    T_reg <= T;
    T_trig <= T & ~T_reg;
    end

if (T_reg) begin
    Q<=~Q;
    end
end

endmodule
