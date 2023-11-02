`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:41:18
// Design Name: 
// Module Name: UpDownCounter_tb
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


module UpDownCounter_tb(   );
reg clk,rst;
wire y;
wire [2:0] state;
UpDownCounter u0(clk,rst,state,y);

initial begin
clk<=0; rst<=0;
#5 rst<=1;
end

always begin
    #5 clk <= ~clk;
end

endmodule
