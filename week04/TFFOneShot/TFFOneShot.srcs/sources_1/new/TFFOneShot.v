`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 21:04:08
// Design Name: 
// Module Name: TFFOneShot
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


module TFFOneShot(clk, rst, T, Q);
input clk, rst, T;
reg T_reg, T_trig;
output reg Q;

always @(posedge clk, negedge rst) begin
    if(!rst) begin
        Q <= 1'b0;
        T_reg <= 1'b0;
        T_trig <= 1'b0;
    end
    else begin
        T_reg <= T;
        T_trig  <= T & ~T_reg;
    end
    
    if(T_trig)
        Q <= ~Q;
end
        
endmodule
