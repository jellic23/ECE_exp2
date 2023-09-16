`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/16 14:11:59
// Design Name: 
// Module Name: comparator_tb
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


module comparator_tb( );
reg [3:0] A,B;
wire A_Larger,Equal,B_Larger;

fourbit_comparator Com(A,B,A_Larger,Equal,B_Larger);


integer i=0;
integer j=0;

initial begin
A=0;B=0;


    for(i=0;i<16;i=i+1)
        begin
        A=i;
            for(j=0;j<16;j=j+1)
                begin
                   B=j;     #2; 
                end
        end  
A=0;B=0;  
end
endmodule
