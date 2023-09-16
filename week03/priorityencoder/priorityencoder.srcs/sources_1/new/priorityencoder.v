`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 17:19:41
// Design Name: 
// Module Name: priorityencoder
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


module priorityencoder(D,x,y,v );
input [3:0] D;
output x,y,v;

assign x= D[3];
assign y= D[3] || ( (~D[2])&&D[1] );
assign v= D[3] || ( (~D[3])&&D[2] ) || ( (~D[3])&&(~D[2])&&D[0] )|| ( (~D[0])&&D[1] ) ;

endmodule
