module compare(
    input [31:0] a,
    input [31:0] b,
    output [31:0] max_number
);
    assign max_number = (a > b) ? a : b;
    
endmodule

module btree(
    input [31:0] a, b, c, d, e,
    input clk,rst,
    output [31:0] max_number,
    output winA,winB,winC,winD,winE
);
    wire [31:0] max_ab, max_cd, max_ab_cd;

    // Compare modules for the first level
    compare comp_ab(.a(a), .b(b), .max_number(max_ab));
    compare comp_cd(.a(c), .b(d), .max_number(max_cd));

    // Compare module for the second level
    compare comp_ab_cd(.a(max_ab), .b(max_cd), .max_number(max_ab_cd));

    // Compare module for the third level
    compare comp_ab_cd_e(.a(max_ab_cd), .b(e), .max_number(max_number));
    
    assign winA = (a == max_number)? 1'b1:1'b0;
    assign winB = (b == max_number)? 1'b1:1'b0;
    assign winC = (c == max_number)? 1'b1:1'b0;
    assign winD = (d == max_number)? 1'b1:1'b0;
    assign winE = (e == max_number)? 1'b1:1'b0;
endmodule

module machine(a,b,c,d,e,win,clk,rst,A,B,C,D,E);
    input a,b,c,d,e,clk,rst;
    output wire [31:0] A,B,C,D,E;
    output [31:0] win_num;
    output [4:0] win;
    // Initialize counters
    counter Av(.up(a),.rst(rst),.clk(clk),.count(A));
    counter Bv(.up(b),.rst(rst),.clk(clk),.count(B));
    counter Cv(.up(c),.rst(rst),.clk(clk),.count(C));
    counter Dv(.up(d),.rst(rst),.clk(clk),.count(D));
    counter Ev(.up(e),.rst(rst),.clk(clk),.count(E));
    // Initialize btree
    btree bt(.a(A),.b(B),.c(C),.d(D),.e(E),.clk(clk),.rst(rst),.max_number(win_num),.winA(win[4]),.winB(win[3]),.winC(win[2]),.winD(win[1]),.winE(win[0]));
    //maybe you need to initialize the compare modules
endmodule

module counter(clk,up,rst,count);
  //define input and output ports
  input clk,up,rst;
  output reg [31:0] count;
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
    reg clk,up,rst,a,b,c,d,e;
    reg [1:0] inp;
    wire [4:0] win;
    wire [31:0] win_num;
    wire [31:0] A,B,C,D,E;
    // instance machine design
    machine mt_1(.a(a),.b(b),.c(c),.d(d),.e(e),.win(win),.rst(rst),.clk(clk));
    counter Av(.up(a),.rst(rst),.clk(clk),.count(A));
    counter Bv(.up(b),.rst(rst),.clk(clk),.count(B));
    counter Cv(.up(c),.rst(rst),.clk(clk),.count(C));
    counter Dv(.up(d),.rst(rst),.clk(clk),.count(D));
    counter Ev(.up(e),.rst(rst),.clk(clk),.count(E));
    btree bt(.a(A),.b(B),.c(C),.d(D),.e(E),.clk(clk),.rst(rst),.max_number(win_num),.winA(win[0]),.winB(win[1]),.winC(win[2]),.winD(win[3]),.winE(win[4]));
    initial begin 
        rst = 1;
        //A = 0;B = 0;C = 0;D = 0;
        #15
        rst = 0;
    end
    //clock generator
    initial begin 
    clk = 1'b0; 
    repeat(500) begin
        #5 clk= ~clk;
    end
    end
    always @(posedge clk) begin
        a = 0; b = 0; c = 0; d = 0;
        inp = $urandom & 15;
        if (inp == 0)
            a = 1;
        else if (inp == 1)
            b = 1;
        else if (inp == 2)
            c = 1;
        else if (inp == 3)
            d = 1;       
        else
            e = 1;
    end

    initial begin 
        $monitor("time=%0d,inp = %d,a = %d,b = %d,c = %d,d = %d,e = %d,A = %0d,B = %0d,C = %0d,D = %0d,E = %0d,win=%0b",$time,inp,a,b,c,d,e,A,B,C,D,E,win);
    end
    
    endmodule