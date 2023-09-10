`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/10 20:38:42
// Design Name: 
// Module Name: fulladder1
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


module fulladder1(
a,b,carryin,cout,sout
    );
    input a,b,carryin;
    output cout,sout;
    wire c_m, s_m,c_m2;
    
    halfadder u0(a,b,c_m,s_m);
    halfadder u1(s_m,carryin,c_m2,sout);
    assign cout = c_m | c_m2;
    
endmodule
