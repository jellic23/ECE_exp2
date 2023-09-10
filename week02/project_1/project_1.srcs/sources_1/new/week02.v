`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/10 17:12:24
// Design Name: 
// Module Name: week02
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


module week02(A[1:0], a, b, c, d, e);
    input[1:0] A;
    output a, b, c, d, e;
    
    assign a = A[0] & A[1]; //and
    assign b = A[0] | A[1]; //or
    assign c = A[0] ^ A[1]; //xor
    assign d = ~(A[0] | A[1]); //nor
    assign e = ~(A[0] & A[1]); //nand
    
endmodule
