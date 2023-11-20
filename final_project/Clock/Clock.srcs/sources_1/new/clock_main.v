`timescale 1us / 1ns

module clock_main(clk, rst, btn, ticking, seg_data, seg_sel);

input clk, rst;
input [3:0] btn;


reg [3:0] btn_t;

output reg [17:0] ticking; //  000000_000000_000000 시, 분, 초.
output [7:0] seg_data;
output [7:0] seg_sel;

integer ta;
integer button_length;
integer button_length_t;
integer hmt_choose;

parameter TIME_SCALE = 1000000;

seg_array SEG1(clk, rst, ticking[17:0], seg_data[7:0], seg_sel[7:0]);
oneshot_universal #(.WIDTH(4)) One1(clk, rst, btn[3:0], btn_t[3:0]);



always @(posedge clk or negedge rst) begin      //시간 설정 모드. 비활성화 필요.
    if(!rst) begin
        ticking <= 18'b000000_000000_000000;
        hmt_choose<=0;
    end
    else begin
        if(button_length_t==1) begin
            if(btn_t[0] == 1) begin
                if(hmt_choose == 3) hmt_choose <= 0;
                /////////////////////////////////////////////

            end
        end  
    end
end

always @(posedge clk or negedge rst) begin      //그냥 시간 증가.
    if(!rst) begin
        ticking <= 18'b000000_000000_000000;
    end
    else begin
        if(button_length_t!=1) begin            //시간설정 비활성화 시 동작
            if(ta==TIME_SCALE) begin
                if(ticking[5:0] < 6'b111011) begin      
                    ticking = ticking + 18'b000000_000000_000001;
                end
                else if(ticking[5:0] == 6'b111011 && ticking[11:6] != 6'b111011) begin
                    ticking[5:0] = 6'b000000;
                    ticking = ticking + 18'b000000_000001_000000;
                end
                else if(ticking[5:0] == 6'b111011 && ticking[11:6] == 6'b111011) begin   
                    ticking[11:0] = 12'b000000_000000;
                    ticking = ticking + 18'b000001_000000_000000;   
                end
                else if(ticking[5:0] == 6'b111011 && ticking[11:6] == 6'b111011 && ticking[17:12] == 6'b010111) begin
                    ticking = 18'b000000_000000_000000;     
                end
            end
        end
    end
end
    
    

always @ (posedge clk or negedge rst) begin //시간 스케일 용 인티저 
    if(!rst) begin
        ta <= 1;
    end
    else begin
        if(ta==TIME_SCALE) ta<=1;
        else ta<=ta+1;
    end        
end

always @ (posedge clk or negedge rst) begin //시간 설정 모드로 활성화 하기  위한 버튼용 인티저. 활성화만 하고 비활성화는 모드 종료 시 한다.
    if(!rst) begin
        button_length <= 1;
        button_length_t <=0;
    end
    else begin
        if(btn[3]==1) begin
            if(button_length == 3*TIME_SCALE) begin
                button_length <= 1;
                button_length_t <=1;
            end
            else begin 
                button_length <= button_length + 1;
            end
        end
        else button_length <=1;
    end        
end



endmodule
