`timescale 1us / 1ns

module Melody_test(clk, rst, btn, piezo);

input clk, rst;
input btn;
output reg piezo;
integer ta; //음의 길이를 지정해주기 위한 변수
integer tb; //다음 멜로디로 진행하기 위한 case 선택 변수

parameter C2 = 12'd3830;
parameter D2 = 12'd3400;
parameter E2 = 12'd3038;
parameter F2 = 12'd2864;
parameter G2 = 12'd2550;
parameter A2 = 12'd2272;
parameter B2 = 12'd2028;
parameter C3 = 12'd1912;

reg [11:0] cnt;
reg [11:0] cnt_limit;

always @(posedge clk or negedge rst) begin
    if(!rst) begin  
        ta=0; tb=0;
    end
    else begin
        case(tb)
            00 : begin
                ta=ta+1;
                cnt_limit = C2;
                if(ta==500000) begin
                       ta=0; tb=tb+1;
                end
            end
            01 : begin
                ta=ta+1;
                cnt_limit = E2;
                if(ta==1000000) begin
                    ta=0; tb=tb+1;
                end
            end
            02 : begin
                ta=ta+1;
                cnt_limit = G2;
                if(ta==2000000) begin
                    ta=0; tb=0;
                end
            end
        endcase
    end
    
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt = 0;
        piezo = 0;
    end
    else if(cnt >= cnt_limit/2) begin
        piezo = ~piezo;
        cnt = 0;
    end
    else cnt = cnt + 1;

end
       

endmodule
