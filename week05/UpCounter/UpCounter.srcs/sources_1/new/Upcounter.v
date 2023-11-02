`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:27:29
// Design Name: 
// Module Name: Upcounter
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


module Upcounter(clk,rst,state);
input clk, rst;
output reg [1:0] state;

always @(negedge rst or posedge clk) begin
    if(!rst) state <= 2'b00;
    else begin
        if(state==2'b11) state <=2'b00;
        else begin state <= state +1; end
    end    
end

endmodule
