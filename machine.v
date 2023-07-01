module machine(a,b,c,d,win,clk,rst,A,B,C,D);
    input a,b,c,d,clk,rst;
    wire [20:0] A,B,C,D;
    output reg[2:0] win;
    counter Av(.up(a),.rst(rst),.clk(clk),.count(A));
    counter Bv(.up(b),.rst(rst),.clk(clk),.count(B));
    counter Cv(.up(c),.rst(rst),.clk(clk),.count(C));
    counter Dv(.up(d),.rst(rst),.clk(clk),.count(D));
    always @* begin
        if (A>B)
            if (A>C)
                if (A>D)
                    win = 2'b00;
                else
                    win = 2'b11;
            else
                if (C>D)
                    win = 2'b10;
                else
                    win = 2'b11;
        else
            if (B>C)
                if (B>D)
                    win = 2'b01;
                else
                    win = 2'b11;
            else
                if (C>D)
                    win = 2'b10;
                else
                    win = 2'b11;
endmodule

    
    