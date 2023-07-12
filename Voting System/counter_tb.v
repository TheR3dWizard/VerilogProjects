

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

module counter_tb;
  reg clk,up,rst;
  wire [20:0] count;
  // instance counter design
  counter ct_1(.up(up),.rst(rst),.clk(clk),.count(count));
  initial begin 
    rst = 1;
    #10
    rst = 0;
    up = 1;
  end
  //clock generator
  initial begin 
  clk = 1'b0; 
  repeat(60) #5 clk= ~clk;
  end

  initial begin 
    $monitor("time=%0d,count=%d",$time,count);
  end
endmodule