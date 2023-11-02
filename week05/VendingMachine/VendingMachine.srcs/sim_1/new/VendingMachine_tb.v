`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:01:16
// Design Name: 
// Module Name: VendingMachine_tb
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


module VendingMachine_tb();
reg clk, rst, A, B, C;
wire [2:0] state;
wire y;

VendingMachine u0 (clk, rst, A, B, C, state, y);

initial begin
clk<=0; rst<=0; A<=0; B<=0; C<=0;
#10 rst <=1;
#10 A<=1; #10 A<=0;
#10 B<=1; #10 B<=0;
#10 A<=1; #10 A<=0;
#10 B<=1; #10 B<=0;
#10 C<=1; #10 C<=0;
#10 rst<=0; #10 rst<=1;
#10 A<=1; #10 A<=0;
#10 B<=1; #10 B<=0;
#10 C<=1; #10 C<=0;
end

always begin
    #5 clk <= ~clk;
end


endmodule
