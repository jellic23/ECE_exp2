`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 20:16:32
// Design Name: 
// Module Name: tb_ripple_adder
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

module week02_1(A, oand, oor, oxor,onor, onand);
input[1:0] A;
output oand, oor, oxor,onor, onand;

assign oand = A[0] & A[1];
assign oor = A[0] | A[1];
assign oxor = A[0] ^ A[1];
assign onor = ~(A[0] | A[1]);
assign onand = ~(A[0] & A[1]);

endmodule
