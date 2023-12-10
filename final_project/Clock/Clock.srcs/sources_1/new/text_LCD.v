`timescale 1us / 1ns


module text_LCD(clk, rst, ta, TIME_SCALE,  ticking, light_time_state, emergency_buffering, LCD_E, LCD_RS, LCD_RW, LCD_DATA);

input clk, rst;
input [47:0] ta;
input [19:0] TIME_SCALE;
input [17:0] ticking;
input [3:0] light_time_state;
input [7:0] emergency_buffering;

wire [23:0] state_bcd;

output LCD_E, LCD_RS, LCD_RW;
output reg [7:0] LCD_DATA;
/* output reg [7:0] LED_out; */

wire LCD_E;
reg LCD_RS, LCD_RW;

reg [47:0] number01;
reg  number02;
integer state_count;

reg [2:0] state;

parameter DELAY = 3'b000,
          FUNCTION_SET = 3'b001,
          DISP_ONOFF   = 3'b010,
          ENTRY_MODE   = 3'b011,
          LINE1        = 3'b100,
          LINE2        = 3'b101,
          DELAY_T      = 3'b110,
          CLEAR_DISP   = 3'b111;

integer cnt;

integer ta1;

bin2bcd B1(clk, rst, ticking[17:0], state_bcd[23:0]);


always @ (posedge clk or negedge rst) begin //시간 스케일 용 인티저 
    if(!rst) begin
        ta1 <= 1;
    end
    else begin
        
            if(ta1==160) ta1<=1;             //try this. original limit was 80
            else ta1<=ta1+1;

    end        
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        number02 <= 0;
        number01 <= 0;
    end
    else begin
        if(ta1==160) begin                   //try this
            number02 = 1;
        end
        
        if(number02 ==1) begin
            number01 = number01 + 1;
            if(number01 == (160)/2) begin        //=40
                number01 = 0;
                number02 = 0;
            end
        end
        
    end
end

always @(posedge clk or negedge rst)
begin
    if(!rst) begin
        state = DELAY;
        state_count = 0;
        cnt = 0;
    end
    else begin
        if(number01==1) begin
            state = CLEAR_DISP;
            state_count = 0;
            cnt=0;
        end
        else begin
            case(state)
                DELAY : begin
/*                 LED_out = 8'b1000_0000;       */
                    if(cnt == 1) begin 
                        state = FUNCTION_SET;
                        cnt = 0;
                    end
                    else cnt = cnt + 1;
                end
                FUNCTION_SET : begin
/*                 LED_out = 8'b0100_0000;       */
                    if(cnt ==1) begin 
                        state = DISP_ONOFF;
                        cnt = 0;
                    end
                    else cnt = cnt + 1;
                end
                DISP_ONOFF : begin
/*                 LED_out = 8'b0010_0000;       */
                    
                    if(cnt ==1) begin 
                        state = ENTRY_MODE;
                        cnt = 0;
                    end
                    else cnt = cnt + 1;
                end
                ENTRY_MODE : begin
/*                 LED_out = 8'b0001_0000;       */
                    if(cnt ==1) begin 
                        state = LINE1;
                        cnt = 0;
                    end
                    else cnt = cnt + 1;
                end
                LINE1 : begin
/*                 LED_out = 8'b0000_1000;       */
                    
                    if(cnt ==36) begin 
                        state = LINE2;
                        cnt = 0;
                        state_count = state_count+1;
                    end
                    else cnt = cnt + 1;
                    
                end
                LINE2 : begin
 /*                LED_out = 8'b0000_0100;       */
 
                        if(cnt ==16) begin 
                            state = DELAY_T;
                            cnt = 0;
                            state_count = state_count+1;
                        end   
                        else cnt = cnt + 1;                       
                end
                DELAY_T : begin
  /*               LED_out = 8'b0000_0010;       */
                    if(state_count >=3) begin
                        if(cnt ==1) begin 
                            state = DELAY_T;
                            cnt = 0;
                        end
                    end
                    else begin
                        if(cnt ==1) begin 
                            state = CLEAR_DISP;
                            cnt = 0;
                            state_count = state_count+1;
                        end
                        else cnt = cnt + 1;
                    end
                end
                CLEAR_DISP : begin
   /*              LED_out = 8'b0000_0001;       */
                    
                    if(cnt == 1) begin
                        state = LINE1;
                        cnt = 0;
                        state_count = state_count+1;
                    end
                    else cnt = cnt + 1;
                    
                end
                default : state = DELAY;
            endcase
        end
    end
end
/*
always @(posedge clk or negedge rst)
begin
    if(!rst)
        cnt = 0;
    else begin
        
            case(state)
                DELAY :
                    if(cnt >= 5) cnt = 0;
                    else cnt = cnt + 1;
                FUNCTION_SET :
                    if(cnt >= 4) cnt = 0;
                    else cnt = cnt + 1;
                DISP_ONOFF :
                    if(cnt >= 3) cnt = 0;
                    else cnt = cnt + 1;
                ENTRY_MODE :
                    if(cnt >= 2) cnt = 0;
                    else cnt = cnt + 1;
                LINE1 :
                    if(24 <= cnt) cnt = 0;
                    else cnt = cnt + 1;
                LINE2 :
                    if(cnt >= 50) cnt = 0;                                 ////////////////////수정됨 
                    else cnt = cnt + 1;
                DELAY_T :
                    if(cnt ==50) cnt = 0;
                    else cnt = cnt + 1;
                CLEAR_DISP :
                    if(cnt == 5) cnt = 0;
                    else cnt = cnt + 1;

                default : state = DELAY;
            endcase
        end
    end
*/
always @(posedge clk or negedge rst)
begin
    if(!rst)
        {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_00000000;
    else begin
        case(state)
            FUNCTION_SET :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0011_1000;
            DISP_ONOFF :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_1100;
            ENTRY_MODE :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0110;
            LINE1 :
                begin
                    case(cnt)
                        20 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1000_0000;
                        21 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0100; //T *
                        22 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1001; //i *
                        23 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1101; //m *
                        24 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0101; //e *
                        25 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                        26 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; //: *
                        27 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                        28 : begin                                           //hour 00 *
                            case(state_bcd[23:20])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        29 : begin                                           //hour 0 *
                            case(state_bcd[19:16])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        30 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; //: *
                        31 : begin                                           //minute 00 *
                            case(state_bcd[15:12])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        32 : begin                                           //minute 0 *
                            case(state_bcd[11:8])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        33 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; //: *
                        34 : begin                                           //second 00 *
                            case(state_bcd[7:4])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        35 : begin                                           //second 0 *
                            case(state_bcd[3:0])
                                0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0000; 
                                1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0001; 
                                2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0010; 
                                3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0011; 
                                4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0100; 
                                5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0101; 
                                6 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0110; 
                                7 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_0111; 
                                8 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1000; 
                                9 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1001; 
                            endcase
                            
                        end
                        36 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // 
                        default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // 
                    endcase
                end
            LINE2 : 
            begin
                    case(cnt)
                        00 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_1100_0000;
                        01 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0101_0011; //S *
                        02 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_0100; //t *
                        03 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0001; //a *
                        04 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_0100; //t *
                        05 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0101; //e *
                        06 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                        07 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0011_1010; //: *
                        08 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                        09 : begin
                            if(emergency_buffering >= 1) begin
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; //A *       emergency situation
                            end
                            else begin
                                if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                
                                    case(light_time_state)
                                        0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; //A *
                                        1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0100; //D *
                                        2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0110; //F *
                                        3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; //E *
                                        4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0111; //G *
                                        5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; //E *
                                    endcase
                                end
                                else begin                                                           //야간
                                    case(light_time_state)
                                        0 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0010; //B *
                                        1 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; //A *
                                        2 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0011; //C *
                                        3 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0001; //A *
                                        4 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_0101; //E *
                                        5 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0100_1000; //H *
                                    endcase
                                end
                            end
                        end
                        10 : begin
                            if(emergency_buffering >= 1) begin
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0001; //, *
                            end
                            else begin
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_1100; //, *
                            end
                        end
                        11 : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                        12 : begin  //Day or Night
                            if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0100; //d *
                            end
                            else begin                                                           //야간
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1110; //n *
                            end
                        end
                        13 : begin  //dAy or nIght
                            if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0001; //a *
                            end
                            else begin                                                           //야간
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1001; //i *
                            end
                        end
                        14 : begin  //daY or niGht
                            if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_1001; //y *
                            end
                            else begin                                                           //야간
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_0111; //g *
                            end
                        end
                        15 : begin  //day or nigHt
                            if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  * 
                            end
                            else begin                                                           //야간
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0110_1000; //h *
                            end
                        end
                        16 : begin  //day or nighT
                            if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간  
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; //  *
                            end
                            else begin                                                           //야간
                                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0111_0100; //t *
                            end
                        end 
                        default : {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_0_0010_0000; // 
                    endcase
            end
            DELAY_T :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0010; //
            CLEAR_DISP :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b0_0_0000_0001; //
            default :
                {LCD_RS, LCD_RW, LCD_DATA} = 10'b1_1_0000_0000; //     
        endcase
    end
end            
        
assign LCD_E = clk;

endmodule
