`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 12:39:32
// Design Name: 
// Module Name: nonblockingmodule_tb
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


module nonblockingmodule_tb();
reg [9:0] A,B,C;
reg  clk;
wire [9:0] D;
nonblockingmodule BM(clk,A,B,C,D);


initial begin
    A=4;B=9;C=14; clk<=0;
    #5 A<=B+C; B<=C+A; C<=A+B;
    #5 A<=B+C; B<=C+A; C<=A+B;
end

always begin
    #5 clk <= ~clk;
end


endmodule
