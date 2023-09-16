`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 14:06:36
// Design Name: 
// Module Name: fourbit_comparator
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


module fourbit_comparator(A,B,x,y,z);
input [3:0] A,B;
output x,y,z;

assign x = (A>B) ? 1:0;     //A>B
assign y = (A==B) ? 1:0;     //A=B
assign z = (A<B) ? 1:0;     //A<B


endmodule
