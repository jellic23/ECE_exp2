`timescale 1us / 1ns

module clock_main(clk, rst, btn, ticking, seg_data, seg_sel);

input clk, rst;
input [3:0] btn;


reg [3:0] btn_t;

output reg [17:0] ticking; //  000000_000000_000000 ��, ��, ��.
output [7:0] seg_data;
output [7:0] seg_sel;

integer ta;
integer button_length;
integer button_length_t;
integer hmt_choose;

parameter TIME_SCALE = 1000000;

seg_array SEG1(clk, rst, ticking[17:0], seg_data[7:0], seg_sel[7:0]);
oneshot_universal #(.WIDTH(4)) One1(clk, rst, btn[3:0], btn_t[3:0]);



always @(posedge clk or negedge rst) begin      //�ð� ���� ���. ��Ȱ��ȭ �ʿ�.
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

always @(posedge clk or negedge rst) begin      //�׳� �ð� ����.
    if(!rst) begin
        ticking <= 18'b000000_000000_000000;
    end
    else begin
        if(button_length_t!=1) begin            //�ð����� ��Ȱ��ȭ �� ����
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
    
    

always @ (posedge clk or negedge rst) begin //�ð� ������ �� ��Ƽ�� 
    if(!rst) begin
        ta <= 1;
    end
    else begin
        if(ta==TIME_SCALE) ta<=1;
        else ta<=ta+1;
    end        
end

always @ (posedge clk or negedge rst) begin //�ð� ���� ���� Ȱ��ȭ �ϱ�  ���� ��ư�� ��Ƽ��. Ȱ��ȭ�� �ϰ� ��Ȱ��ȭ�� ��� ���� �� �Ѵ�.
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
