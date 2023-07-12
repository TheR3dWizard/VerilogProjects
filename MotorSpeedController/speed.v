module speed (input clk,rst,
input [7:0] threshold,af,bf,
output [7:0] speed);

reg [7:0] temp_af,temp_bf;
always @(posedge clk) begin
    if (rst) begin
        assign speed = 0;
    end else begin
        if (speed < threshold) begin
            temp_af = af + 10;
        end else if (speed > threshold) begin
            temp_bf = threshold - speed;
            temp_af = 0;
        end
    end
end

assign speed = speed + af - bf;
endmodule

module speed_tb;
    reg clk,rst;
    reg [7:0] threshold;
    reg [7:0] af,bf;
    wire [7:0] speed;

    speed speedtb(.clk(clk),.rst(rst),.threshold(threshold),.af(af),.bf(bf),.speed(speed));

    initial begin
        rst = 1;
        clk = 0;
        threshold = 100;
        af = 0;
        bf = 0;
        speed = 25;
        #10 rst = 0;
    end

    initial begin
        repeat(100) begin
            #5 clk = ~clk;
        end
    end

    initial begin
        $monitor("clk=%b rst=%b threshold=%d af=%d bf=%d speed=%d",clk,rst,threshold,af,bf,speed);
    end

endmodule

