`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/22 15:13:34
// Design Name: 
// Module Name: JKFF_tb
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


module JKFF_tb();
reg clk, J,K;
wire Q;
JKFF JKJK(clk, J, K, Q);

initial begin
    clk<=0; {J,K}<=2'b00;
    #20 {J,K}<=2'b01;
    #20 {J,K}<=2'b00;
    #20 {J,K}<=2'b10;
    #20 {J,K}<=2'b00;
    #20 {J,K}<=2'b11;
    #20 {J,K}<=2'b00;
    

end

always begin
    #5 clk <= ~clk;
end
endmodule
