`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 16:48:22
// Design Name: 
// Module Name: decoder_3X8_tb
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


module decoder_3X8_tb( );
reg [2:0] inA;
wire [7:0] outB;

decoder_3X8 Dec0308 (inA, outB);

initial begin

for(inA=0;inA<8;inA=inA+1)
    begin
        #10;
    end    
inA=0;
end

endmodule
