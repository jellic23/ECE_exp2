`timescale 1ns / 1ps

module test_code_ff_tb();

reg clk, rst;
wire number;

test_code_ff TC1(clk, rst, number);

initial begin
    rst<=0; clk<=0;
    #8 rst<=1;
end


always begin
    #0.5 clk <= ~clk;
end


endmodule
