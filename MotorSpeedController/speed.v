module speed (
  input clk,
  input rst,
  input [7:0] threshold,
  input [7:0] af,
  input [7:0] bf,
  output [7:0] speed,
  output [7:0] o_af,
  output [7:0] o_bf
);

reg [7:0] temp_af,temp_bf;

if (rst) begin
    assign temp_af = 0;
    assign temp_bf = 0;
    assign speed = 0;
end 

always @(posedge clk) begin
        if (speed < threshold) begin
            temp_af = af + 10;
        end else if (speed > threshold) begin
            temp_bf = threshold - speed;
            temp_af = 0;
        end
    end


assign speed = speed + af - bf;
assign o_af = temp_af;
assign o_bf= temp_bf;
endmodule

module speed_tb;
    reg clk;
    reg rst;
    reg [7:0] threshold;
    reg [7:0] af,bf;
    wire [7:0] speed,o_af,o_bf;

 speed #(.rst(1'b0)) speedtb (
    .clk(clk),
    .rst(rst),
    .threshold(threshold),
    .af(af),
    .bf(bf),
    .speed(speed),
    .o_af(o_af),
    .o_bf(o_bf)
  );
  
    initial begin
        rst = 1;
        clk = 0;
        threshold = 100;
        af = 0;
        bf = 0;
        #10 rst = 0;
    end

    initial begin
        repeat(100) begin
            #5 clk = ~clk;
        end
    end

    always @(negedge clk) begin
        af = o_af;
        bf = o_bf;
    end

    initial begin
        $monitor("time = %0d, clk=%b rst=%b threshold=%d af=%d bf=%d speed=%d",$time,clk,rst,threshold,af,bf,speed);
    end

endmodule

