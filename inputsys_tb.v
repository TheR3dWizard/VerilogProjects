`timescale 1ns / 1ps

module inputsys(a,b,c,d,z);
    input a,b,c,d;
    output reg [2:0] z;
    always @(a or b or c or d)
    if(a)
        z = 2'b00;
    else if(b)
        z = 2'b01;
    else if(c)
        z = 2'b10;       
    else if(d)
        z = 2'b11;
endmodule

module inputsys_tb;
    reg a,b,c,d;
    wire [2:0] z;

    inputsys in_1(.a(a),.b(b),.c(c),.d(d),.z(z));
    initial begin
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        #10 a = 1;
        #10 a = 0; b = 1;
        #10 b = 0; c = 1;
        #10 c = 0; d = 1;
    end

    initial begin
        $monitor("time = %0d a = %d b = %d c = %d d = %d z = %d",$time,a,b,c,d,z);
    end
endmodule