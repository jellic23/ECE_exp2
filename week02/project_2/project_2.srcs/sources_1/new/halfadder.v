`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/10 18:42:10
// Design Name: 
// Module Name: halfadder
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

module halfadder(a,b,c,s);
input a,b;
output reg c,s;
wire [1:0] concat_input;

assign concat_input = {a,b};

always @(*) begin
case(concat_input)
2'b00:
begin c=0; s=0; end 
2'b01: 
begin c=0; s=1; end
2'b10: 
begin c=0; s=1; end
2'b11: 
begin c=1; s=0; end
endcase
end
endmodule



