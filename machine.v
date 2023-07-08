module machine(a,b,c,d,win,clk,rst,A,B,C,D);
    input a,b,c,d,clk,rst;
    wire [20:0] A,B,C,D;
    output reg[4:0] win;
    counter Av(.up(a),.rst(rst),.clk(clk),.count(A));
    counter Bv(.up(b),.rst(rst),.clk(clk),.count(B));
    counter Cv(.up(c),.rst(rst),.clk(clk),.count(C));
    counter Dv(.up(d),.rst(rst),.clk(clk),.count(D));
    always @* begin
        if (A>B)
            if (A>C)
                if (A>D)
                    if (A>E)
                        win = 5'b00000;
                    
endmodule

    
module compare(
  input [31:0] a, b, c, d, e,
  output [31:0] max_number
);

  // Compare module for two numbers
  module compare(
    input [31:0] a,
    input [31:0] b,
    output [31:0] max_number
  );
    assign max_number = (a > b) ? a : b;
  endmodule

  // Compare modules for the first level
  compare comp_ab(.a(a), .b(b), .max_number(max_ab));
  compare comp_cd(.a(c), .b(d), .max_number(max_cd));

  // Compare module for the second level
  compare comp_ab_cd(.a(max_ab), .b(max_cd), .max_number(max_ab_cd));

  // Compare module for the third level
  compare comp_ab_cd_e(.a(max_ab_cd), .b(e), .max_number(max_number));

endmodule