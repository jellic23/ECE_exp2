
module logicgate_tb(

    );
    reg[1:0] in;
    wire a, b, c, d, e;
    
    week02 u0 (in[1:0], a, b, c,d,e);
    
    initial begin
    in[1]=0; in[0]=0;
    in[1]=0; in[0]=0; #10
    in[1]=0; in[0]=1; #10
    in[1]=1; in[0]=0; #10
    in[1]=1; in[0]=1; #10
    in[1]=0; in[0]=0;
    end
endmodule
