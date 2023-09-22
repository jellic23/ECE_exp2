`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 18:02:47
// Design Name: 
// Module Name: TFF_withOneShot_tb
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


module TFF_withOneShot_tb();
reg clk, rst, T;
wire Q;
TFF_withOneShot u1(clk,rst,T,Q);

initial begin
    clk<=0; rst<=0; //set Q=1'b0 by doing rst<=0;
    #20 rst<=1; //enable rst trigger
    #80 T <=0; //Q
    #80 T <=1; //toggle
    #80 T <=0; //Q
    #80 T <=1; //toggle
    #80 T <=0; //Q
    #80 T <=1; //toggle
    #80 T <=0; //Q
    #80 T <=1; //toggle
    #80 T <=0;
end

always begin
    #5 clk <= ~clk;
end


endmodule