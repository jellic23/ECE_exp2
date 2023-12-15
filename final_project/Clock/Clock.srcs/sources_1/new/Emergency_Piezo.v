`timescale 1ns / 1ps

module Emergency_Piezo(clk, rst, TIME_SCALE, emergency_buffering, emergency_clkby, piezo);

input clk, rst;
input [47:0] TIME_SCALE;
input [7:0] emergency_buffering;
input [47:0] emergency_clkby;

output reg piezo;



reg [11:0] cnt;
reg [11:0] cnt_limit;
parameter S1 = 12'd40;    //low ti
parameter C2 = 12'd38;    //do  3
parameter D2 = 12'd34;    //re  2
parameter E2 = 12'd30;    //mi  1
parameter F2 = 12'd29;    //fa  3
parameter G2 = 12'd26;    //sol  2
parameter A2 = 12'd23;    //la  1
parameter B2 = 12'd20;    //ti
parameter C3 = 12'd1912;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt_limit <= 0;
    end
    else begin
        if(emergency_buffering >= 4 && emergency_buffering <= 7) begin
            if(TIME_SCALE == 10000) begin
                if(emergency_clkby<=5000) begin
                    cnt_limit = A2;
                end
                else begin
                    cnt_limit = E2;
                end
            end
            else if (TIME_SCALE == 1000) begin
                if(emergency_clkby<=500) begin
                    cnt_limit = A2;
                end
                else begin
                    cnt_limit = E2;
                end
            end
            else if (TIME_SCALE == 100) begin
                if(emergency_clkby<=50) begin
                    cnt_limit = A2;
                end
                else begin
                    cnt_limit = E2;
                end
            end
            else if (TIME_SCALE == 50) begin
                if(emergency_clkby<=5) begin
                    cnt_limit = A2;
                end
                else begin
                    cnt_limit = E2;
                end
            end
        end
        else if(emergency_buffering == 8) begin         //passing
            if(TIME_SCALE == 10000) begin
                if(emergency_clkby<=5000) begin
                    cnt_limit = G2;
                end
                else begin
                    cnt_limit = D2;
                end
            end
            else if (TIME_SCALE == 1000) begin
                if(emergency_clkby<=500) begin
                    cnt_limit = G2;
                end
                else begin
                    cnt_limit = D2;
                end
            end
            else if (TIME_SCALE == 100) begin
                if(emergency_clkby<=50) begin
                    cnt_limit = G2;
                end
                else begin
                    cnt_limit = D2;
                end
            end
            else if (TIME_SCALE == 50) begin
                if(emergency_clkby<=5) begin
                    cnt_limit = G2;
                end
                else begin
                    cnt_limit = D2;
                end
            end
        end
        else if(emergency_buffering >= 9 && emergency_buffering <= 12) begin
            if(TIME_SCALE == 10000) begin
                if(emergency_clkby<=5000) begin
                    cnt_limit = F2;
                end
                else begin
                    cnt_limit = C2;
                end
            end
            else if (TIME_SCALE == 1000) begin
                if(emergency_clkby<=500) begin
                    cnt_limit = F2;
                end
                else begin
                    cnt_limit = C2;
                end
            end
            else if (TIME_SCALE == 100) begin
                if(emergency_clkby<=50) begin
                    cnt_limit = F2;
                end
                else begin
                    cnt_limit = C2;
                end
            end
            else if (TIME_SCALE == 50) begin
                if(emergency_clkby<=5) begin
                    cnt_limit = F2;
                end
                else begin
                    cnt_limit = C2;
                end
            end
        end    
    end
end


always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt = 0;
        piezo = 0;
    end
    else begin
        if(emergency_buffering >= 4 && emergency_buffering <= 12) begin
            if(cnt >= cnt_limit/2) begin
                piezo = ~piezo;
                cnt = 0;
            end
            else cnt = cnt + 1;
        end
    end
    

end






endmodule
