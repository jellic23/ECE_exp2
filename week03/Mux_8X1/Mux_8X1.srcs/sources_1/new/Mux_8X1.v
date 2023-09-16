`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 17:39:43
// Design Name: 
// Module Name: Mux_8X1
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


module Mux_8X1(in0,in1,in2,in3,in4,in5,in6,in7, Signal,outR);
input [2:0] in0,in1,in2,in3,in4,in5,in6,in7;
input [2:0] Signal;
output reg [2:0] outR;

always @(Signal) begin
    case(Signal)
        3'b000 : outR=in0;
        3'b001 : outR=in1;
        3'b010 : outR=in2;
        3'b011 : outR=in3;
        3'b100 : outR=in4;
        3'b101 : outR=in5;
        3'b110 : outR=in6;
        3'b111 : outR=in7;
    endcase        

end

endmodule
