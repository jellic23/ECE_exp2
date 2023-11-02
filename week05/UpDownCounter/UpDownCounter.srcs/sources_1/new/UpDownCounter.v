`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/28 17:40:51
// Design Name: 
// Module Name: UpDownCounter
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


module UpDownCounter(clk,rst,state,x,y);
input x;
input clk, rst;
output reg [2:0] state;
output reg y;
reg x_reg, x_trig;

parameter UP =1'b0;
parameter DOWN =1'b1;

//x의 원샷 트리거 구현하기!
always @(negedge rst or posedge clk) begin
    if(!rst) begin
        x_reg<=0;
        x_trig<=0;
    end
    else begin
        x_trig <= x & ~x_reg;
        x_reg <= x;
    end
end
        


always @(negedge rst or posedge clk) begin
    if(!rst) state <= 3'b000;
    else begin
    
        if(state==3'b111) y=DOWN;
        else if (state==3'b000) y=UP;
        
        if(x_trig==1) begin
            case(y)
                UP: state<=state+1;
                DOWN: state<=state-1;
            endcase
        end
    end    
end

endmodule