`timescale 1us / 1ns

module clock_main(clk, rst, btn, emergency_btn, addhour_btn, seg_data, seg_sel, south, north, west, east, south_p, north_p, west_p, east_p,LCD_E, LCD_RS, LCD_RW, LCD_DATA, piezo, led_signal_R, led_signal_G, led_signal_B);

input clk, rst;
input [3:0] btn;
input emergency_btn;
input addhour_btn;


wire [3:0] btn_t;
wire emergency_btn_t;
wire addhour_btn_t;

reg [17:0] ticking; //  000000_000000_000000 시, 분, 초.
reg [17:0] ticking2; //  000000_000000_000000 시, 분, 초.  for 신호등

output [7:0] seg_data;
output [7:0] seg_sel;
output LCD_E, LCD_RS, LCD_RW;
output [7:0] LCD_DATA;

output reg [3:0] south;     //순서는, green, yellow, red, left
output reg [3:0] north;     //순서는, green, yellow, red, left
output reg [3:0] west;      //순서는, green, yellow, red, left
output reg [3:0] east;      //순서는, green, yellow, red, left
output reg [1:0] south_p;     //순서는, green, red                 pedestrian*
output reg [1:0] north_p;     //순서는, green, red
output reg [1:0] west_p;      //순서는, green, red
output reg [1:0] east_p;      //순서는, green, red

output piezo;
output [3:0] led_signal_R;
output [3:0] led_signal_G;
output [3:0] led_signal_B;


reg [47:0] ta;
reg [47:0] ta2;
reg [3:0] light_time;
reg [3:0] light_time_state;

reg [47:0] TIME_SCALE;
reg [47:0] flickering;
integer test;

reg [47:0] emergency_clkby;
integer emergency_indicate_int_1;
reg [7:0] emergency_buffering;

integer daynight_indicator;
integer TIME_SCALEa;

text_LCD TL1(clk, rst, ta, TIME_SCALE[47:0], ticking[17:0], light_time_state[3:0], emergency_buffering[7:0], LCD_E, LCD_RS, LCD_RW, LCD_DATA[7:0]);
seg_array SEG1(clk, rst, ticking[17:0], seg_data[7:0], seg_sel[7:0]);
oneshot_universal #(.WIDTH(6)) One1(clk, rst, {btn[3:0], emergency_btn, addhour_btn}, {btn_t[3:0], emergency_btn_t, addhour_btn_t});
Emergency_Piezo EP1(clk, rst, TIME_SCALE[47:0], emergency_buffering[7:0], emergency_clkby[47:0], piezo);
LED L1(clk, rst, TIME_SCALE[47:0], emergency_buffering[7:0], emergency_clkby[47:0], led_signal_R[3:0], led_signal_G[3:0],led_signal_B[3:0]);

always @(posedge clk or negedge rst) begin      //메인 시간 증가.
    if(!rst) begin
        ticking <= 18'b000000_000000_000000;
    end
    else begin
        if(addhour_btn_t==1 && ticking[17:12] != 6'b010111) begin
            ticking = ticking + 18'b000001_000000_000000;
        end
        else if(addhour_btn_t==1 && ticking[17:12] == 6'b010111) begin
            ticking[17:12] = 6'b000000;
        end
        else begin
                if(ta==TIME_SCALE) begin
                    if(ticking[5:0] < 6'b111011) begin      
                        ticking = ticking + 18'b000000_000000_000001;
                    end
                    else if(ticking[5:0] == 6'b111011 && ticking[11:6] != 6'b111011) begin
                        ticking[5:0] = 6'b000000;
                        ticking = ticking + 18'b000000_000001_000000;
                    end
                    else if(ticking[5:0] == 6'b111011 && ticking[11:6] == 6'b111011&& ticking[17:12] != 6'b010111) begin   
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
   /* 
always @(posedge clk or negedge rst) begin      //신호등 시간 증가.    필요없음*****************
    if(!rst) begin
        ticking2 <= 18'b000000_000000_000000;
    end
    else begin
        if(addhour_btn_t==1 && ticking2[17:12] != 6'b010111) begin
            ticking2 = ticking2 + 18'b000001_000000_000000;
        end
        else if(addhour_btn_t==1 && ticking2[17:12] == 6'b010111) begin
            ticking2[17:12] = 6'b000000;
        end
        else begin
                if(ta2==TIME_SCALEa) begin
                    if(ticking2[5:0] < 6'b111011) begin      
                        ticking2 = ticking2 + 18'b000000_000000_000001;
                    end
                    else if(ticking2[5:0] == 6'b111011 && ticking2[11:6] != 6'b111011) begin
                        ticking2[5:0] = 6'b000000;
                        ticking2 = ticking2 + 18'b000000_000001_000000;
                    end
                    else if(ticking2[5:0] == 6'b111011 && ticking2[11:6] == 6'b111011&& ticking2[17:12] != 6'b010111) begin   
                        ticking2[11:0] = 12'b000000_000000;
                        ticking2 = ticking2 + 18'b000001_000000_000000;   
                    end
                else if(ticking2[5:0] == 6'b111011 && ticking2[11:6] == 6'b111011 && ticking2[17:12] == 6'b010111) begin
                        ticking2 = 18'b000000_000000_000000;     
                    end
                end
            end
        end
    end
    */
always @(posedge clk or negedge rst) begin      //light_time_state에 따른 신호등 state 변화 입력..
    if(!rst) begin
        south = 4'b0110; north = 4'b0110; west = 4'b0110; east = 4'b0110;
        south_p = 2'b00; north_p = 2'b00; west_p = 2'b00; east_p = 2'b00;
    end
    else begin
      if(1 <= emergency_buffering && emergency_buffering <= 15) begin
          south = 4'b1000; north = 4'b1000; west = 4'b0010; east = 4'b0010;
          south_p = 2'b01; north_p = 2'b01; west_p = 2'b10; east_p = 2'b10;
      end
      else begin
        if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin                                                             //주간
           case(light_time_state)
               0 : begin                                                            //state A* 보행점멸 구현 완료..
                   if((TIME_SCALEa*5)/2 <= flickering) begin                                                       
                       if((TIME_SCALEa*5)/2 <= flickering && flickering < (TIME_SCALEa*6)/2) begin
                           west_p = 2'b00; east_p = 2'b00;
                       end
                       else if((TIME_SCALEa*6)/2 <= flickering && flickering < (TIME_SCALEa*7)/2) begin
                           west_p = 2'b10; east_p = 2'b10;
                       end
                       else if((TIME_SCALEa*7)/2 <= flickering && flickering < (TIME_SCALEa*8)/2) begin
                           west_p = 2'b00; east_p = 2'b00;
                       end
                       else if((TIME_SCALEa*8)/2 <= flickering && flickering < (TIME_SCALEa*9)/2) begin
                           west_p = 2'b10; east_p = 2'b10;
                           south = 4'b0100; north = 4'b0100;
                       end
                       else if((TIME_SCALEa*9)/2 <= flickering && flickering < (TIME_SCALEa*10)/2) begin
                           west_p = 2'b00; east_p = 2'b00;
                           south = 4'b0100; north = 4'b0100;
                       end 
                   end
                   else begin
                       south = 4'b1000; north = 4'b1000; west = 4'b0010; east = 4'b0010;
                       south_p = 2'b01; north_p = 2'b01; west_p = 2'b10; east_p = 2'b10;
                   end
               end
               1 : begin                                                            //state D* 보행점멸 없음.
                   if(TIME_SCALEa*4 <= flickering) begin
                       if(TIME_SCALEa*4 <= flickering && flickering < TIME_SCALEa*4 + TIME_SCALEa/4) begin
                           south = 4'b0011; north = 4'b0011;
                       end
                       else if(TIME_SCALEa*4 + (TIME_SCALEa)/4 <= flickering && flickering < TIME_SCALEa*4 + (TIME_SCALEa*2)/4) begin
                           south = 4'b0110; north = 4'b0110;
                       end
                       else if(TIME_SCALEa*4 + (TIME_SCALEa*2)/4 <= flickering && flickering < TIME_SCALEa*4 + (TIME_SCALEa*3)/4) begin
                           south = 4'b0110; north = 4'b0110;
                       end
                       else if(TIME_SCALEa*4 + (TIME_SCALEa*3)/4 <= flickering && flickering < TIME_SCALEa*4 + (TIME_SCALEa*4)/4) begin
                           south = 4'b0010; north = 4'b0010;
                       end
                   end
                   else begin 
                       south = 4'b0011; north = 4'b0011; west = 4'b0010; east = 4'b0010;
                       south_p = 2'b01; north_p = 2'b01; west_p = 2'b01; east_p = 2'b01;
                   end      
               end
               2 : begin                                                            //state F* 보행점멸 구현 완료.
                   if((TIME_SCALEa*5)/2 <= flickering) begin                                                       
                       if((TIME_SCALEa*5)/2 <= flickering && flickering < (TIME_SCALEa*6)/2) begin
                           north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*6)/2 <= flickering && flickering < (TIME_SCALEa*7)/2) begin
                           north_p = 2'b10;
                       end
                       else if((TIME_SCALEa*7)/2 <= flickering && flickering < (TIME_SCALEa*8)/2) begin
                           north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*8)/2 <= flickering && flickering < (TIME_SCALEa*9)/2) begin
                           north_p = 2'b10;
                           west = 4'b1100;
                       end
                       else if((TIME_SCALEa*9)/2 <= flickering && flickering < (TIME_SCALEa*10)/2) begin
                           north_p = 2'b00;
                           west = 4'b1100;
                       end 
                   end
                   else begin
                       south = 4'b0010; north = 4'b0010; west = 4'b1001; east = 4'b0010;
                       south_p = 2'b01; north_p = 2'b10; west_p = 2'b01; east_p = 2'b01;
                   end
               end
               3 : begin                                                            //state E* 보행점멸 구현 완료.
                   if((TIME_SCALEa*5)/2 <= flickering) begin                                                       
                       if((TIME_SCALEa*5)/2 <= flickering && flickering < (TIME_SCALEa*6)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*6)/2 <= flickering && flickering < (TIME_SCALEa*7)/2) begin
                           south_p = 2'b10; north_p = 2'b10;
                       end
                       else if((TIME_SCALEa*7)/2 <= flickering && flickering < (TIME_SCALEa*8)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*8)/2 <= flickering && flickering < (TIME_SCALEa*9)/2) begin
                           south_p = 2'b10; north_p = 2'b10;
                           west = 4'b0100;
                       end
                       else if((TIME_SCALEa*9)/2 <= flickering && flickering < (TIME_SCALEa*10)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                           west = 4'b0100;
                       end 
                   end
                   else begin
                       south = 4'b0010; north = 4'b0010; west = 4'b1000; east = 4'b1000;
                       south_p = 2'b10; north_p = 2'b10; west_p = 2'b01; east_p = 2'b01;
                   end
               end
               4 : begin                                                            //state G* 보행점멸 구현 완료
                   if((TIME_SCALEa*5)/2 <= flickering) begin                                                       
                       if((TIME_SCALEa*5)/2 <= flickering && flickering < (TIME_SCALEa*6)/2) begin
                           south_p = 2'b00;
                       end
                       else if((TIME_SCALEa*6)/2 <= flickering && flickering < (TIME_SCALEa*7)/2) begin
                           south_p = 2'b10;
                       end
                       else if((TIME_SCALEa*7)/2 <= flickering && flickering < (TIME_SCALEa*8)/2) begin
                           south_p = 2'b00;
                       end
                       else if((TIME_SCALEa*8)/2 <= flickering && flickering < (TIME_SCALEa*9)/2) begin
                           south_p = 2'b10;
                           east = 4'b1100;
                       end
                       else if((TIME_SCALEa*9)/2 <= flickering && flickering < (TIME_SCALEa*10)/2) begin
                           south_p = 2'b00;
                           east = 4'b1100;
                       end 
                   end
                   else begin
                       south = 4'b0010; north = 4'b0010; west = 4'b0010; east = 4'b1001;
                       south_p = 2'b10; north_p = 2'b01; west_p = 2'b01; east_p = 2'b01;
                   end
               end
               5 : begin                                                            //state E* 보행점멸 구현 완료.
                   if((TIME_SCALEa*5)/2 <= flickering) begin                                                       
                       if((TIME_SCALEa*5)/2 <= flickering && flickering < (TIME_SCALEa*6)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*6)/2 <= flickering && flickering < (TIME_SCALEa*7)/2) begin
                           south_p = 2'b10; north_p = 2'b10;
                       end
                       else if((TIME_SCALEa*7)/2 <= flickering && flickering < (TIME_SCALEa*8)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                       end
                       else if((TIME_SCALEa*8)/2 <= flickering && flickering < (TIME_SCALEa*9)/2) begin
                           south_p = 2'b10; north_p = 2'b10;
                           west = 4'b0100; east = 4'b0100;
                       end
                       else if((TIME_SCALEa*9)/2 <= flickering && flickering < (TIME_SCALEa*10)/2) begin
                           south_p = 2'b00; north_p = 2'b00;
                           west = 4'b0100; east = 4'b0100;
                       end 
                   end
                   else begin
                       south = 4'b0010; north = 4'b0010; west = 4'b1000; east = 4'b1000;
                       south_p = 2'b10; north_p = 2'b10; west_p = 2'b01; east_p = 2'b01;
                   end
               end
           endcase
        end
        else begin                                                                                                               //야간
               case(light_time_state)
                   0 : begin                                                            //state B* 보행점멸 구현 완료 
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
                           if((TIME_SCALEa*10)/2 <= flickering && flickering < (TIME_SCALEa*11)/2) begin
                               east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*11)/2 <= flickering && flickering < (TIME_SCALEa*12)/2) begin
                               east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*12)/2 <= flickering && flickering < (TIME_SCALEa*13)/2) begin
                               east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*13)/2 <= flickering && flickering < (TIME_SCALEa*14)/2) begin
                               east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*14)/2 <= flickering && flickering < (TIME_SCALEa*15)/2) begin
                               east_p = 2'b00;
                           end 
                           else if((TIME_SCALEa*15)/2 <= flickering && flickering < (TIME_SCALEa*16)/2) begin
                               east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*16)/2 <= flickering && flickering < (TIME_SCALEa*17)/2) begin
                               east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*17)/2 <= flickering && flickering < (TIME_SCALEa*18)/2) begin
                               east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               east_p = 2'b00;
                               north = 4'b1100;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               east_p = 2'b10;
                               north = 4'b1100;
                           end
                       end
                       else begin
                           south = 4'b0010; north = 4'b1001; west = 4'b0010; east = 4'b0010;
                           south_p = 2'b01; north_p = 2'b01; west_p = 2'b01; east_p = 2'b10;
                       end
                   end
                   1 : begin                                                            //state A* 보행점멸 구현 완료..
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
                           if((TIME_SCALEa*10)/2 <= flickering && flickering < (TIME_SCALEa*11)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*11)/2 <= flickering && flickering < (TIME_SCALEa*12)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*12)/2 <= flickering && flickering < (TIME_SCALEa*13)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*13)/2 <= flickering && flickering < (TIME_SCALEa*14)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*14)/2 <= flickering && flickering < (TIME_SCALEa*15)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end 
                           else if((TIME_SCALEa*15)/2 <= flickering && flickering < (TIME_SCALEa*16)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*16)/2 <= flickering && flickering < (TIME_SCALEa*17)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*17)/2 <= flickering && flickering < (TIME_SCALEa*18)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                               north = 4'b0100;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                               north = 4'b0100;
                           end
                       end
                       else begin
                           south = 4'b1000; north = 4'b1000; west = 4'b0010; east = 4'b0010;
                           south_p = 2'b01; north_p = 2'b01; west_p = 2'b10; east_p = 2'b10;
                       end
                   end
                   2 : begin                                                            //state C* 보행점멸 구현 완료.
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
                           if((TIME_SCALEa*10)/2 <= flickering && flickering < (TIME_SCALEa*11)/2) begin
                               west_p = 2'b00;
                           end
                           else if((TIME_SCALEa*11)/2 <= flickering && flickering < (TIME_SCALEa*12)/2) begin
                               west_p = 2'b10;
                           end
                           else if((TIME_SCALEa*12)/2 <= flickering && flickering < (TIME_SCALEa*13)/2) begin
                               west_p = 2'b00;
                           end
                           else if((TIME_SCALEa*13)/2 <= flickering && flickering < (TIME_SCALEa*14)/2) begin
                               west_p = 2'b10;
                           end
                           else if((TIME_SCALEa*14)/2 <= flickering && flickering < (TIME_SCALEa*15)/2) begin
                               west_p = 2'b00;
                           end 
                           else if((TIME_SCALEa*15)/2 <= flickering && flickering < (TIME_SCALEa*16)/2) begin
                               west_p = 2'b10; 
                           end
                           else if((TIME_SCALEa*16)/2 <= flickering && flickering < (TIME_SCALEa*17)/2) begin
                               west_p = 2'b00; 
                           end
                           else if((TIME_SCALEa*17)/2 <= flickering && flickering < (TIME_SCALEa*18)/2) begin
                               west_p = 2'b10; 
                           end
                           else if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               west_p = 2'b00; 
                               south = 4'b1100;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               west_p = 2'b10;
                               south = 4'b1100;
                           end
                       end
                       else begin
                           south = 4'b1001; north = 4'b0010; west = 4'b0010; east = 4'b0010;
                           south_p = 2'b01; north_p = 2'b01; west_p = 2'b10; east_p = 2'b01;
                       end
                   end
                   3 : begin                                                            //state A* 보행점멸 구현 완료..
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
                           if((TIME_SCALEa*10)/2 <= flickering && flickering < (TIME_SCALEa*11)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*11)/2 <= flickering && flickering < (TIME_SCALEa*12)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*12)/2 <= flickering && flickering < (TIME_SCALEa*13)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*13)/2 <= flickering && flickering < (TIME_SCALEa*14)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*14)/2 <= flickering && flickering < (TIME_SCALEa*15)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end 
                           else if((TIME_SCALEa*15)/2 <= flickering && flickering < (TIME_SCALEa*16)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*16)/2 <= flickering && flickering < (TIME_SCALEa*17)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                           end
                           else if((TIME_SCALEa*17)/2 <= flickering && flickering < (TIME_SCALEa*18)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                           end
                           else if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               west_p = 2'b00; east_p = 2'b00;
                               south = 4'b0100; north = 4'b0100;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               west_p = 2'b10; east_p = 2'b10;
                               south = 4'b0100; north = 4'b0100;
                           end
                       end
                       else begin
                           south = 4'b1000; north = 4'b1000; west = 4'b0010; east = 4'b0010;
                           south_p = 2'b01; north_p = 2'b01; west_p = 2'b10; east_p = 2'b10;
                       end
                   end
                   4 : begin                                                            //state E* 보행점멸 구현 완료.
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
                           if((TIME_SCALEa*10)/2 <= flickering && flickering < (TIME_SCALEa*11)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALEa*11)/2 <= flickering && flickering < (TIME_SCALEa*12)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALEa*12)/2 <= flickering && flickering < (TIME_SCALEa*13)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALEa*13)/2 <= flickering && flickering < (TIME_SCALEa*14)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALEa*14)/2 <= flickering && flickering < (TIME_SCALEa*15)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end 
                           else if((TIME_SCALEa*15)/2 <= flickering && flickering < (TIME_SCALEa*16)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALEa*16)/2 <= flickering && flickering < (TIME_SCALEa*17)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALEa*17)/2 <= flickering && flickering < (TIME_SCALEa*18)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                               west = 4'b0100; east = 4'b0100;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                               west = 4'b0100; east = 4'b0100;
                           end
                       end
                       else begin
                           south = 4'b0010; north = 4'b0010; west = 4'b1000; east = 4'b1000;
                           south_p = 2'b10; north_p = 2'b10; west_p = 2'b01; east_p = 2'b01;
                       end
                   end
                   5 : begin                                                            //state H* 보행점멸 없음.
                       if((TIME_SCALEa*10)/2 <= flickering) begin                                                       
/*                           if((TIME_SCALE*10)/2 <= flickering && flickering < (TIME_SCALE*11)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALE*11)/2 <= flickering && flickering < (TIME_SCALE*12)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALE*12)/2 <= flickering && flickering < (TIME_SCALE*13)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALE*13)/2 <= flickering && flickering < (TIME_SCALE*14)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALE*14)/2 <= flickering && flickering < (TIME_SCALE*15)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end 
                           else if((TIME_SCALE*15)/2 <= flickering && flickering < (TIME_SCALE*16)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end
                           else if((TIME_SCALE*16)/2 <= flickering && flickering < (TIME_SCALE*17)/2) begin
                               south_p = 2'b00; north_p = 2'b00;
                           end
                           else if((TIME_SCALE*17)/2 <= flickering && flickering < (TIME_SCALE*18)/2) begin
                               south_p = 2'b10; north_p = 2'b10;
                           end  */
                           if((TIME_SCALEa*18)/2 <= flickering && flickering < (TIME_SCALEa*19)/2) begin
                               west = 4'b0110; east = 4'b0110;
                           end
                           else if((TIME_SCALEa*19)/2 <= flickering && flickering < (TIME_SCALEa*20)/2) begin
                               west = 4'b0110; east = 4'b0110;
                           end
                       end
                       else begin
                           south = 4'b0010; north = 4'b0010; west = 4'b0011; east = 4'b0011;
                           south_p = 2'b01; north_p = 2'b01; west_p = 2'b01; east_p = 2'b01;
                       end
                   end
               endcase
            end
        end
    end    
end

always @ (posedge clk or negedge rst) begin //시간 스케일 용 인티저 
    if(!rst) begin
        ta <= 1;
    end
    else begin
        if(btn_t == 4'b1000 || btn_t == 4'b0100 || btn_t == 4'b0010 || btn_t == 4'b0001) begin
            ta =1;
        end
        else begin
            if(ta==TIME_SCALE) ta<=1;
            else ta<=ta+1;
        end 
    end        
end
always @ (posedge clk or negedge rst) begin //신호등 시계를 위함. 
    if(!rst) begin
        ta2 <= 1;
    end
    else begin
        
            if(ta2==TIME_SCALEa) ta2<=1;
            else ta2<=ta2+1;

    end        
end

always @ (posedge clk or negedge rst) begin //응급차량 용 리얼타임
    if(!rst) begin
        emergency_clkby<=0;
        emergency_indicate_int_1<=0;
        emergency_buffering <=0;
    end
    else begin
        if(emergency_btn_t == 1) begin
            emergency_indicate_int_1=1;
        end 
        
        if(emergency_indicate_int_1==1) begin
            if(btn_t == 4'b1000 || btn_t == 4'b0100 || btn_t == 4'b0010 || btn_t == 4'b0001) begin
                emergency_clkby =0;
            end
            else begin
                if(emergency_clkby==TIME_SCALEa) emergency_clkby<=1;
                else emergency_clkby<=emergency_clkby+1;
                if(emergency_clkby==TIME_SCALEa) begin
                emergency_buffering = emergency_buffering +1;
                if(emergency_buffering ==16) begin
                    emergency_indicate_int_1=0;
                    emergency_buffering=0;
                end
            end
            end 
        end
    end
end
/*
always @ (posedge clk or negedge rst) begin //응급차량 대기용 인티저 based on emergency_clkby.
    if(!rst) begin
        emergency_buffering <=0;
    end
    else begin
 //       if(emergency_btn_t == 1) begin
 //           emergency_indicate_int_1=1;
 //       end     
        if(emergency_indicate_int_1==1) begin
            if(emergency_clkby==TIME_SCALE) begin
                emergency_buffering = emergency_buffering +1;
                if(emergency_buffering ==16) begin
                    emergency_indicate_int_1=0;
                    emergency_buffering=0;
                end
            end
        end
    end        
end
*/
always @(posedge clk or negedge rst) begin      //신호등용 인티저. 주간, 야간 구분.
    if(!rst) begin
        light_time <= 0;
        light_time_state <= 0;
        flickering <= 0;//깜빡임 및 황색 신호  구현 위한 시간 증가. 주간, 야간 구분, 주간에는 flickering=0 ~ 5*TIME_SCALE-1=49999, 야간에는 0 ~ 10*TIME_SCALE-1=99999
        TIME_SCALEa = 10000;
    end
    else begin
        if(1 <= emergency_buffering && emergency_buffering <= 15) begin
            light_time = 0;
            flickering = 0;
        end
        else begin  
            if(6'b001000<=ticking2[17:12] && ticking2[17:12] <= 6'b010110)  begin  //주간
                flickering = flickering +1;
                if(ta2==TIME_SCALEa) light_time = light_time + 1;
            
                if(ticking2 == 18'b001000_000000_000000) begin
                    light_time = 0;
                    light_time_state = 0;
                    flickering=98;
                end
            
            
                if(light_time == 5) begin
                    light_time = 0;
                    light_time_state = light_time_state + 1;
                    flickering=0;
                    if(light_time_state == 6) light_time_state = 0;
                end
            end
            else begin                                                      //야간
                flickering = flickering +1;
                if(ta2==TIME_SCALEa) light_time = light_time + 1;
            
                if(addhour_btn_t==1 && ticking2[17:12] == 6'b000111) light_time = light_time - 5;
                if(ticking2 == 18'b010111_000000_000000) begin
                    light_time = 0;
                    light_time_state = 0;
                    flickering=98;
                end
            
                if(light_time == 10) begin
                    light_time = 0;
                    light_time_state = light_time_state + 1;
                    flickering=0;
                    if(light_time_state == 6) light_time_state = 0;
                end
            end
        end
    end 
end

always @(posedge clk or negedge rst) begin      //타임스케일 변경.
    if(!rst) begin
        TIME_SCALE <=10000;
    end
    else begin
            case(btn_t)
                4'b0001 : begin
                TIME_SCALE = 10000; 
                end
                4'b0010 : begin 
                TIME_SCALE = 1000; 
                end
                4'b0100 : begin
                    TIME_SCALE = 100; 
                end
                4'b1000 : begin
                    TIME_SCALE = 50; 
                end
                
            endcase
    end
end


/*
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
*/

/*
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
*/
always @ (posedge clk or negedge rst) begin //밤낮 확인
    if(!rst) begin
        daynight_indicator <=0;
    end
    else begin
        if(6'b001000<=ticking[17:12] && ticking[17:12] <= 6'b010110)  begin  //주간
            daynight_indicator <=1;
        end
        else daynight_indicator <=0;                                           //야간
    end        
end

endmodule
