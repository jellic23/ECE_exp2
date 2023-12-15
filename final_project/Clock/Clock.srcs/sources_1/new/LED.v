`timescale 1us / 1ns

module LED(clk, rst, TIME_SCALE, emergency_buffering, emergency_clkby, led_signal_R, led_signal_G,led_signal_B);

input clk, rst;
input [47:0] TIME_SCALE;
input [7:0] emergency_buffering;
input [47:0] emergency_clkby;

reg [7:0] cnt;
reg [23:0] state;
/* 
reg [23:0] state1;
reg [23:0] state2;
reg [23:0] state3;
reg [23:0] state4;
reg [47:0] rainbow01;
reg  rainbow02;
integer rain1;
reg [7:0] cnt1;
reg [7:0] cnt1a;
*/ 
output reg [3:0] led_signal_R;
output reg [3:0] led_signal_G;
output reg [3:0] led_signal_B;

parameter red    = {8'd255, 8'd0  , 8'd0  };
parameter orange = {8'd255, 8'd102, 8'd0  };
parameter yellow = {8'd255, 8'd255, 8'd0  };
parameter green  = {8'd0  , 8'd255, 8'd0  };
parameter blue   = {8'd0  , 8'd0  , 8'd255};
parameter indigo = {8'd0  , 8'd0  , 8'd128};
parameter purple = {8'd128, 8'd0  , 8'd128};
parameter pink   = {8'd255, 8'd0  , 8'd203};
parameter white  = {8'd255, 8'd255, 8'd255};
parameter black  = {8'd0  , 8'd0  , 8'd0  };
parameter brown  = {8'd120, 8'd70 , 8'd70 };
parameter bright_yellow = {8'd192, 8'd192, 8'd0  };
parameter cyan  = {8'd0  , 8'd255 , 8'd255};



/*
always @(posedge clk or posedge rst) begin
    if(rst) state <= 24'd0;
    else begin
        if(TIME_SCALE == 10000) begin
        
        end
        else if(TIME_SCALE == 1000) begin
        
        end
        else if(TIME_SCALE == 100) begin
        
        end
        else if(TIME_SCALE == 50) begin
        
        end
    end
end
*/

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= 24'd0;
        led_signal_R <= 4'b0000;
        led_signal_G <= 4'b0000;
        led_signal_B <= 4'b0000;
    end
    else begin
        if(emergency_buffering >= 1) begin
                    
                        if(emergency_clkby >= (TIME_SCALE*0)/14 && emergency_clkby <= (TIME_SCALE*1)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b0111;  //1
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*2)/14 && emergency_clkby <= (TIME_SCALE*3)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b0111;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*4)/14 && emergency_clkby <= (TIME_SCALE*5)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b0111;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*6)/14 && emergency_clkby <= (TIME_SCALE*7)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b01111;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*7)/14 && emergency_clkby <= (TIME_SCALE*8)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b1110;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*9)/14 && emergency_clkby <= (TIME_SCALE*10)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b1110;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*11)/14 && emergency_clkby <= (TIME_SCALE*12)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b1110;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else if(emergency_clkby >= (TIME_SCALE*13)/14 && emergency_clkby <= (TIME_SCALE*14)/14) begin
                            state = green;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b1110;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                        else begin
                            state = black;
                            if(cnt < state[23:16]) led_signal_R <= 4'b1111;
                            else led_signal_R <= 4'b0000;
                            if(cnt < state[15:8]) led_signal_G <= 4'b0111;
                            else led_signal_G <= 4'b0000;
                            if(cnt < state[7:0]) led_signal_B <= 4'b1111;
                            else led_signal_B <= 4'b0000;
                        end
                    
        end
        else begin
/*                        if(cnt<=cnt1) state = red;
                        else state = yellow; */
                        if(     TIME_SCALE == 10000) state = black;
                        else if(TIME_SCALE == 1000 ) state = red;
                        else if(TIME_SCALE == 100  ) state = orange;
                        else if(TIME_SCALE == 50   ) state = yellow;
                        
                            if(cnt < state[23:16]) begin 
                                led_signal_R = 4'b1111;
                            end
                            else begin 
                                led_signal_R = 4'b0000;
                            end
                            if(cnt < state[15:8]) begin 
                                led_signal_G = 4'b1111;
                            end
                            else begin 
                                led_signal_G = 4'b0000;
                            end
                            if(cnt < state[7:0]) begin 
                                led_signal_B = 4'b0000;
                            end
                            else begin 
                                led_signal_B = 4'b0000;
                            end
        end
        
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt <= 8'b0000_0000;
    end
    else cnt <= cnt +1;
end

/*
always @(posedge clk or posedge rst) begin
    if(rst) begin
        led_signal_R <= 4'b0000;
        led_signal_G <= 4'b0000;
        led_signal_B <= 4'b0000;
    end
    else begin
        if(cnt < state[23:16]) led_signal_R <= 4'b1111;
        else led_signal_R <= 4'b0000;
        
        if(cnt < state[15:8]) led_signal_G <= 4'b1111;
        else led_signal_G <= 4'b0000;
        
        if(cnt < state[7:0]) led_signal_B <= 4'b1111;
        else led_signal_B <= 4'b0000;
    end
end
*/
/*
always @ (posedge clk or negedge rst) begin //
    if(!rst) begin
        rain1 <= 1;
    end
    else begin
        
            if(rain1==40) rain1<=1;             //try this. 
            else rain1<=rain1+1;

    end        
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        rainbow02 <= 0;
        rainbow01 <= 0;
    end
    else begin
        if(rain1==40) begin                   //try this
            rainbow02 = 1;
        end
        
        if(rainbow02 ==1) begin
            rainbow01 = rainbow01 + 1;
            if(rainbow01 == (40)/2) begin        //=40
                rainbow01 = 0;
                rainbow02 = 0;
            end
        end
        
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt1 <= 8'b0000_0000;
    end
    else begin 
        if(rain1==1)
        cnt1 = cnt1 +1;
    end
end
*/
/*
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt1 <= 8'b0000_0000;
    end
    else begin 
        if(rainbow01 == 1)
        cnt1 <= cnt1 +1;
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        cnt1a <= 8'b0000_0000;
    end
    else begin 
        if(rain1 == 1&&cnt1==1)
        cnt1a = cnt1a +1;
        if(cnt1a ==256) cnt1a = 0;
    end
end
        */
endmodule
