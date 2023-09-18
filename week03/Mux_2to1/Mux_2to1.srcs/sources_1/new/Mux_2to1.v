`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/18 10:14:20
// Design Name: 
// Module Name: Mux_2to1
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


module Mux_2to1(in0,in1,in2,in3,Signal,outR);
    input [1:0] in0,in1,in2,in3;
input [1:0] Signal;
output reg [1:0] outR;

always @(Signal) begin
    case(Signal)
        2'b00 : outR=in0;
        2'b01 : outR=in1;
        2'b10 : outR=in2;
        2'b11 : outR=in3; 
    endcase        

end

endmodule
