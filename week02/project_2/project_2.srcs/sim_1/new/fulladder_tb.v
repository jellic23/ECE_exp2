`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/10 20:28:58
// Design Name: 
// Module Name: fulladder_tb
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


module fulladder_tb(

    );
    reg x,y,carryin;
    wire carryout,sumout;
    
 fulladder1 FA(x,y,carryin,carryout,sumout);
 
    initial begin
    carryin=0; x=0; y=0; 
    carryin=0; x=0; y=0; #10;
    carryin=0; x=0; y=1; #10; 
    carryin=0; x=1; y=0; #10;
    carryin=1; x=0; y=0; #10;
    carryin=1; x=0; y=1; #10;
    carryin=1; x=1; y=0; #10;
    carryin=1; x=1; y=1; 
    end
endmodule
