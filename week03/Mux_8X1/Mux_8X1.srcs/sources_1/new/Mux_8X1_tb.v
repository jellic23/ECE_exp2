`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 17:52:04
// Design Name: 
// Module Name: Mux_8X1_tb
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


module Mux_8X1_tb();
reg [2:0] in0,in1,in2,in3,in4,in5,in6,in7;
reg [2:0] Signal;
wire [2:0] outR;
Mux_8X1 Mux0801 (in0,in1,in2,in3,in4,in5,in6,in7, Signal,outR);

initial 
begin

in0=3'b000;
in1=3'b001;
in2=3'b010;
in3=3'b011;
in4=3'b100;
in5=3'b101;
in6=3'b110;
in7=3'b111;

for(Signal=0;Signal<8;Signal=Signal+1)
    begin
        #10;
    end    
end

endmodule
