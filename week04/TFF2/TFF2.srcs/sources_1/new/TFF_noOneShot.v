`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 18:04:19
// Design Name: 
// Module Name: TFF_noOneShot
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


module TFF_noOneShot(clk,rst,T,Q);
input clk, rst, T;
output reg Q;

always @(posedge clk or negedge rst) begin
if(!rst)
    Q<=1'b0;
else if(T)
    Q<=~Q;    

end

endmodule
