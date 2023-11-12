`timescale 1us / 1ns

module LED_color_control_tb();

reg clk, rst;
reg [7:0] btn;

wire [3:0] led_signal_R;
wire [3:0] led_signal_G;
wire [3:0] led_signal_B;

LED_color_control LEDcolcon1(clk, rst, btn[7:0], led_signal_R[3:0], led_signal_G[3:0],led_signal_B[3:0]);

initial begin
    rst<=1; clk<=0; btn<=0;
    #10 rst <= 0;
    #1000 btn <= 8'b00000001; //red
    #1000 btn <= 8'b00000010; //orange
    #1000 btn <= 8'b00000100; //yellow
    #1000 btn <= 8'b00000000;
end
    
always begin
    #0.5 clk <= ~clk;
end
endmodule
