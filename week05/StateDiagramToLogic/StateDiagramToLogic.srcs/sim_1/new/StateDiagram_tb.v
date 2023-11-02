`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 14:23:21
// Design Name: 
// Module Name: StateDiagram_tb
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


module StateDiagram_tb();
reg x;
reg clk, rst;
wire [1:0] state;
wire y;
StateDiagram u0(clk, rst, x, y, state);




initial begin
clk<=0; rst<=0; x<=0;
#10 rst <= 1;
#10 x<=1'b1;//
#10 x<=0;//4.1.2
#10 x<=1;//wait...
#10 x<=1;//4.1.3
#10 x<=1;//wati...
#10 x<=0;//4.1.4
#10 x<=1;#10 x<=1;#10 x<=1;//wait
#10 x<=1;//4.1.5
#10 x<=0;#10 x<=1;#10 x<=1;//wait
#10 x<=0;//4.1.6

end

always begin
    #5 clk <= ~clk;
end

endmodule