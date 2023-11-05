`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/04 16:27:53
// Design Name: 
// Module Name: bin_to_BCD_tb
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


module bin_to_BCD_tb();

reg clk, rst;
reg [3:0] bin;
wire [7:0] bcd;

bin_to_BCD u0(clk, rst, bin, bcd);

initial begin
clk<=0;rst<=0; #10 rst<=1;
#10 bin<=4'b0000;
#10 bin<=4'b0001;
#10 bin<=4'b0010;
#10 bin<=4'b0011;
#10 bin<=4'b0100;
#10 bin<=4'b0101;
#10 bin<=4'b0110;
#10 bin<=4'b0111;
#10 bin<=4'b1000;
#10 bin<=4'b1001;
#10 bin<=4'b1010;
#10 bin<=4'b1011;
#10 bin<=4'b1100;
#10 bin<=4'b1101;
#10 bin<=4'b1110;
#10 bin<=4'b1111;
end

always begin
    #5 clk <= ~clk;
end

endmodule
