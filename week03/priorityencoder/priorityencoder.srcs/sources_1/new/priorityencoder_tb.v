`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 17:25:35
// Design Name: 
// Module Name: priorityencoder_tb
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


module priorityencoder_tb();
reg [3:0] D;
wire x,y,v;

priorityencoder PE(D,x,y,v );

initial begin

for(D=0;D<16;D=D+1)
    begin
        #10;
    end

end

endmodule
