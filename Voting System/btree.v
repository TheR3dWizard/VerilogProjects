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

module compare_tb;
    reg [31:0] a, b, c, d, e;
    reg clk,rst;
    wire [31:0] max_number;
    wire winA,winB,winC,winD,winE;
    btree btree_inst(.a(a), .b(b), .c(c), .d(d), .e(e),.clk(clk),.rst(rst),.max_number(max_number), .winA(winA), .winB(winB), .winC(winC), .winD(winD), .winE(winE));
    initial begin
        clk = 0;
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        e = 0;
        rst = 1'b1;
        #10;
        rst = 1'b0;
    end
    initial repeat(10) begin
        clk = ~clk;
        a = $urandom & 50;
        b = $urandom & 50;
        c = $urandom & 50;
        d = $urandom & 50;
        e = $urandom & 50;
        #10;
        
    end
    initial begin
        $monitor("a=%0d, b=%0d, c=%0d, d=%0d, e=%0d, max_number=%0d,win = %0b%0b%0b%0b%0b", a, b, c, d, e, max_number,winA,winB,winC,winD,winE);
    end
endmodule