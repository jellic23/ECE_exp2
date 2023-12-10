`timescale 1us / 1ns


module seg_array(clk, rst, ticking, seg_data,seg_sel);

input clk, rst;
input [17:0] ticking;
/*  btn;
wire btn_trig;
reg [3:0] state_bin; */

wire [23:0] state_bcd;
output reg [7:0] seg_data;
output reg [7:0] seg_sel;
reg [3:0] bcd;


bin2bcd B1(clk, rst, ticking[17:0], state_bcd[23:0]);

/* oneshot_universal #(.WIDTH(1)) One1(clk, rst, btn, btn_trig); */

/*
always @(posedge clk or negedge rst) begin
    if(!rst) state_bin <= 4'b0000;
    else if (state_bin == 4'b1111 && btn_trig ==1) state_bin <= 4'b0000;
    else if(btn_trig == 1) state_bin <= state_bin +1;
end
*/

always @(posedge clk or negedge rst) begin
    if(!rst) seg_sel <= 8'b11111110;
    else begin
        seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end
end

always @(*) begin
    case (bcd[3:0])
        0 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11111101;
            else seg_data = 8'b11111100;          //
        end 
        1 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b01100001;
            else seg_data = 8'b01100000;
        end
        2 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11011011;
            else seg_data = 8'b11011010;
        end
        3 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11110011;
            else seg_data = 8'b11110010;
        end
        4 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b01100111;
            else seg_data = 8'b01100110;
        end
        5 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b10110111;
            else seg_data = 8'b10110110;
        end
        6 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b10111111;
            else seg_data = 8'b10111110;
        end
        7 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11100001;
            else seg_data = 8'b11100000;
        end
        8 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11111111;
            else seg_data = 8'b11111110;
        end
        9 : begin
            if(seg_sel==8'b11111110 || seg_sel==8'b11111011 || seg_sel==8'b11101111 ) seg_data = 8'b11110111;
            else seg_data = 8'b11110110;
        end
        default : seg_data = 8'b00000000;
    endcase
end

always @(*) begin
    case(seg_sel)
        8'b11111110 : bcd = state_bcd[3:0];
        8'b11111101 : bcd = state_bcd[7:4];
        8'b11111011 : bcd = state_bcd[11:8];
        8'b11110111 : bcd = state_bcd[15:12];
        8'b11101111 : bcd = state_bcd[19:16];
        8'b11011111 : bcd = state_bcd[23:20];
        8'b10111111 : bcd = 4'b1100;
        8'b01111111 : bcd = 4'b1100;
        default : bcd =4'b0000;
    endcase
end


endmodule
