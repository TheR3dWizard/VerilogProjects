module machine(a,b,c,d,win,clk,rst,A,B,C,D);
    input a,b,c,d,clk,rst;
    output wire [20:0] A,B,C,D;
    output reg[2:0 ] win;
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
    end
endmodule

module counter(clk,up,rst,count);
  //define input and output ports
  input clk,up,rst;
  output reg [20:0] count;
  //always block will be executed at each and every positive edge of the clock
  always@(posedge clk) 
  begin
    if(rst)
      count <= 4'd0;
    else if(up)        //count up
      count <= count + 1;
    
  end

endmodule
    
module machine_tb;
    reg clk,up,rst,a,b,c,d;
    reg [1:0] inp;
    wire [2:0] win;
    reg [20:0] A,B,C,D;
    // instance machine design
    machine mt_1(.a(a),.b(b),.c(c),.d(d),.win(win),.rst(rst),.clk(clk));
    initial begin 
        rst = 1;
        A = 0;B = 0;C = 0;D = 0;
        #10
        rst = 0;
    end
    //clock generator
    initial begin 
    clk = 1'b0; 
    repeat(60) begin
        #5 clk= ~clk;
    end
    end
    always @(posedge clk) begin
        a = 0; b = 0; c = 0; d = 0;
        inp = $urandom & 7;
        if (inp == 0)
            a = 1;
        else if (inp == 1)
            b = 1;
        else if (inp == 2)
            c = 1;
        else if (inp == 3)
            d = 1;       
    end

    initial begin 
        $monitor("time=%0d,inp = %d,a = %d,b = %d,c = %d,d = %d,A = %0d,B = %0d,C = %0d,D = %0d,win=%d",$time,inp,a,b,c,d,A,B,C,D,win);
    end
    
    endmodule