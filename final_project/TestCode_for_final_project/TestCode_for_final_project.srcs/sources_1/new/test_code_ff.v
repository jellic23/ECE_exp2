`timescale 1ns / 1ps

module test_code_ff(clk, rst, number, outnum, sosu);

input clk, rst ;

reg [3:0] number_array;
output reg number;
output reg outnum;
output reg [7:0] sosu;



always @(posedge clk or negedge rst or negedge clk) begin
    if(!rst) begin
        number <= 0;
        number_array <= 0;
    end
    else begin
        if(number==1) begin
            number_array=number_array+1;
            if(number_array==10) begin
                number =0;
                number_array=0;
                
            end
        end
        else begin
            number_array=number_array+1;
            if(number_array==10) begin
                number = 1;
                number_array=0;
            end
        end
        
    end
 
end

always @(posedge number or negedge rst or negedge number) begin
    if(!rst) begin
        outnum=0;
    end
    else begin
        outnum = number;
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        sosu<=0;
    end
    else begin
        sosu = sosu + 1/10;
    end
    
end

endmodule
