`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 16:44:24
// Design Name: 
// Module Name: decoder_3X8
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


module decoder_3X8(A,B);
input [2:0] A;
output reg [7:0] B;

always @(A)
begin
    B=8'b0;
    B[A]=1'b1;
end    
endmodule
