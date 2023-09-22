`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 13:59:30
// Design Name: 
// Module Name: JKFF
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


module JKFF(clk, J, K, Q);
input clk, J, K;
output reg Q;

always @(posedge clk) begin
    if(J==0 && K==0)
    begin
        Q<=Q;
    end
    else if(J==0 && K==1)
    begin
        Q<=1'b0;
    end
    else if(J==1 && K==0)
    begin
        Q<=1'b1;
    end
    else if(J==1 && K==1)
    begin
        Q<=~Q;
    end
end

endmodule
